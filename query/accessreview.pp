query "azuread_guest_user_access_reviews_configured" {
  sql = <<-EOQ
    with tenant_list as (
      select distinct on (tenant_id) tenant_id, _ctx
      from azuread_user
    ),
    guest_user_access_reviews as (
      select
        tenant_id,
        count(*) as guest_user_access_review
      from
        azuread_access_review_schedule_definition
      where
        display_name = 'Review guest access across Microsoft 365 groups'
        and (settings -> 'mailNotificationsEnabled')::bool
        and (settings -> 'reminderNotificationsEnabled')::bool
        and (settings -> 'justificationRequiredOnApproval')::bool
        and settings -> 'recurrence' -> 'pattern' ->> 'type' in ('absoluteMonthly', 'weekly')
        and (settings -> 'autoApplyDecisionsEnabled')::bool
        and settings ->> 'defaultDecision' = 'Deny'
      group by tenant_id
    )
    select
      t.tenant_id as resource,
      case
        when guest_user_access_review > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when guest_user_access_review > 0
          then t.tenant_id || ' has Access Reviews configured for guest users.'
        else t.tenant_id || ' does not have Access Reviews configured for guest users.'
      end as reason
      ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "t.")}
    from
      tenant_list as t
      left join guest_user_access_reviews as p on p.tenant_id = t.tenant_id;
  EOQ
}

query "azuread_privileged_roles_access_reviews_configured" {
  sql = <<-EOQ
    with tenant_list as (
      select distinct on (tenant_id) tenant_id, _ctx
      from azuread_user
    ),
    privileged_roles as (
      select
        tenant_id,
        id,
        display_name
      from
        azuread_directory_role_definition
      where
        display_name in (
          'Global Administrator',
          'Exchange Administrator',
          'SharePoint Administrator',
          'Teams Administrator',
          'Security Administrator'
        )
    ),
    privileged_role_reviews as (
      select
        ar.tenant_id,
        d.id
      from
        azuread_access_review_schedule_definition ar,
        jsonb_array_elements(ar.scope -> 'resourceScopes') as r
        join azuread_directory_role_definition d
          on split_part(r ->> 'query', 'roleDefinitions/', 2) = d.id
      where
        (ar.settings -> 'mailNotificationsEnabled')::bool
        and (ar.settings -> 'reminderNotificationsEnabled')::bool
        and (ar.settings -> 'justificationRequiredOnApproval')::bool
        and ar.settings ->> 'defaultDecision' = 'Deny'
    ),
    role_check as (
      select
        tenant_id,
        array_agg(distinct id)::text[] as roles_reviewed
      from
        privileged_role_reviews
      group by tenant_id
    )
    select
      t.tenant_id as resource,
      case
        when array(select id from privileged_roles where tenant_id = t.tenant_id)
            <@ coalesce(r.roles_reviewed, '{}')
          then 'ok'
          else 'alarm'
        end as status,
        case
          when array(select id from privileged_roles where tenant_id = t.tenant_id)
              <@ coalesce(r.roles_reviewed, '{}')
          then t.tenant_id || ' has Access Reviews configured monthly (or more frequently) for all high-privileged roles (Global Administrator, Exchange Administrator, SharePoint Administrator, Teams Administrator, Security Administrator).'
          else t.tenant_id || ' does not have Access Reviews configured monthly for all high-privileged roles. Missing: '
              || array_to_string(
                    array(
                      select pr.display_name
                      from privileged_roles pr
                      where pr.tenant_id = t.tenant_id
                      and pr.id not in (
                        select unnest(coalesce(r.roles_reviewed, '{}'))
                      )
                    ), ', '
                  )
        end as reason
        ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "t.")}
      from
        tenant_list as t
        left join role_check as r on r.tenant_id = t.tenant_id;

  EOQ
}
