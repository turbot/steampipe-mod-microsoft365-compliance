query "azuread_legacy_authentication_disabled" {
  sql = <<-EOQ
    with block_legacy_authentication as (
      select
        tenant_id,
        count(*)
      from
        azuread_conditional_access_policy
      where
        client_app_types ?& array['exchangeActiveSync', 'other']
        and built_in_controls ?& array['block']
        and users -> 'includeUser' ?& array['All']
        and jsonb_array_length(users -> 'excludeUser') != 0
      group by
        tenant_id
    ),
    tenant_list as(
      select
        distinct on(tenant_id) tenant_id,
        _ctx
      from
        azuread_user
    )
    select
      tenant_id as resource,
      case
        when (select count from block_legacy_authentication where tenant_id = t.tenant_id) > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when (select count from block_legacy_authentication where tenant_id = t.tenant_id) > 0 then tenant_id || ' has Conditional Access policies enabled.'
        else tenant_id || ' has Conditional Access policies disabled.'
      end as reason
      ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "t.")}
    from
      tenant_list as t;
  EOQ
}

query "azuread_signin_frequency_policy" {
  sql = <<-EOQ
    with users_having_admin_roles as (
      select
        array_agg(role_template_id) as rid
      from
        azuread_directory_role
      where
        display_name like '%Administrator'
    ),
    signin_frequency_enabled as (
      select
        tenant_id,
        count(p.*)
      from
        azuread_conditional_access_policy as p,
        users_having_admin_roles as a
      where
        (p.users -> 'includeRoles')::jsonb ?| (a.rid)
        and (p.sign_in_frequency -> 'isEnabled')::bool
        and (p.persistent_browser -> 'isEnabled')::bool
        and p.persistent_browser ->> 'mode'='never'
        and p.applications -> 'includeApplications' ?& array['All']
        and jsonb_array_length(p.applications -> 'excludeApplications') = 0
        and jsonb_array_length(p.built_in_controls) = 1
        and p.built_in_controls ?& array['mfa']
        and state = 'enabled'
      group by
        tenant_id
    ),
    tenant_list as (
      select
        distinct on (tenant_id) tenant_id,
        _ctx
      from
        azuread_user
    )
    select
      tenant_id as resource,
      case
        when (select count from signin_frequency_enabled where tenant_id = t.tenant_id) > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when (select count from signin_frequency_enabled where tenant_id = t.tenant_id) > 0 then tenant_id || ' has sign-in frequency policy enabled.'
        else tenant_id || ' has sign-in frequency policy disabled.'
      end as reason
      ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "t.")}
    from
      tenant_list as t;
  EOQ
}

query "azuread_signin_risk_policy" {
  sql = <<-EOQ
    with block_legacy_authentication as (
      select
        tenant_id,
        count(*)
      from
        azuread_conditional_access_policy
      where
        users->'includeUsers' ?& array['All'] and
        jsonb_array_length(users -> 'excludeUsers') = 0 and
        jsonb_array_length(sign_in_risk_levels) != 0 and
        applications->'includeApplications' ?& array['All'] and
        jsonb_array_length(applications -> 'excludeApplications') = 0 and
        built_in_controls ?& array['mfa']
      group by
        tenant_id
    ),
    tenant_list as (
      select
        distinct on (tenant_id) tenant_id,
        _ctx
      from
        azuread_user
    )
    select
      t.tenant_id as resource,
      case
        when (select count from block_legacy_authentication where tenant_id = t.tenant_id) > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when (select count from block_legacy_authentication where tenant_id = t.tenant_id) > 0 then t.tenant_id || ' has sign-in risk policies enabled.'
        else t.tenant_id || ' has sign-in risk policies disabled.'
      end as reason
      ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "t.")}
    from
      tenant_list as t;
  EOQ
}