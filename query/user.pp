query "azuread_admin_user_mfa_enabled" {
  sql = <<-EOQ
    with users_having_admin_roles as (
      select
        array_agg(role_template_id) as rid
      from
        azuread_directory_role
      where
        display_name like '%Administrator'
    ),
    policy_with_mfa as (
      select
        tenant_id,
        count(p.*)
      from
        azuread_conditional_access_policy as p,
        users_having_admin_roles as a
      where
        p.built_in_controls ?& array['mfa']
        and (p.users -> 'includeRoles')::jsonb ?| (a.rid)
        and jsonb_array_length(p.users -> 'excludeUsers') < 1
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
        when (select count from policy_with_mfa where tenant_id = t.tenant_id) > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when (select count from policy_with_mfa where tenant_id = t.tenant_id) > 0 then t.tenant_id || ' has MFA enabled for all users in administrative roles.'
        else t.tenant_id || ' has MFA disabled for all users in administrative roles.'
      end as reason
      ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "t.")}
    from
      tenant_list as t;
  EOQ
}

query "azuread_all_user_mfa_enabled" {
  sql = <<-EOQ
    with users_having_admin_roles as (
      select
        array_agg(role_template_id) as rid
      from
        azuread_directory_role
    ),
    policy_with_mfa as (
      select
        tenant_id,
        count(p.*)
      from
        azuread_conditional_access_policy as p,
        users_having_admin_roles as a
      where
        p.built_in_controls ?& array['mfa']
        and (p.users -> 'includeRoles')::jsonb ?| (a.rid)
        and jsonb_array_length(p.users -> 'excludeUsers') < 1
      group by
        tenant_id
    ),
    tenant_list as (
      select
        distinct on (tenant_id) tenant_id,
        _ctx,
        id,
        display_name
      from
        azuread_user
    )
    select
      t.tenant_id as resource,
      case
        when (select count from policy_with_mfa where tenant_id = t.tenant_id) > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when (select count from policy_with_mfa where tenant_id = t.tenant_id) > 0 then t.tenant_id || ' has MFA enabled for all users.'
        else t.tenant_id || ' has MFA disabled for all users.'
      end as reason
      ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "t.")}
    from
      tenant_list as t;
  EOQ
}

query "azuread_guest_user_info" {
  sql = <<-EOQ
    select
      id as resource,
      case
        when user_type = 'Guest' then 'info'
        else 'skip'
      end as status,
      case
        when user_type = 'Guest' then display_name || ' is guest user.'
        else display_name || ' is ' || user_type || ' user.'
      end as reason
      ${local.common_dimensions_sql}
    from
      azuread_user;
  EOQ
}

query "azuread_user_password_not_set_to_expire" {
  sql = <<-EOQ
    select
      id as resource,
      case
        when user_type !='Member' then 'skip'
        when password_policies like '%DisablePasswordExpiration%' then 'ok'
        else 'alarm'
      end as status,
      case
        when user_type !='Member' then display_name || ' is ' || user_type || ' user.'
        when password_policies like '%DisablePasswordExpiration%' then display_name || ' has password expiration disabled.'
        else display_name || ' has password expiration enabled.'
      end as reason
      ${local.common_dimensions_sql}
    from
      azuread_user;
  EOQ
}

query "azuread_user_risk_policy" {
  sql = <<-EOQ
    with block_legacy_authentication as (
      select
        tenant_id,
        count(*)
      from
        azuread_conditional_access_policy
      where
        users->'includeUsers' ?& array['All']
        and jsonb_array_length(users -> 'excludeUsers') = 0
        and jsonb_array_length(user_risk_levels) != 0
        and applications->'includeApplications' ?& array['All']
        and jsonb_array_length(applications -> 'excludeApplications') = 0
        and built_in_controls ?& array['passwordChange']
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
        when (select count from block_legacy_authentication where tenant_id = t.tenant_id) > 0 then t.tenant_id || ' has user risk policies enabled.'
        else t.tenant_id || ' has user risk policies disabled.'
      end as reason
      ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "t.")}
    from
      tenant_list as t;
  EOQ
}

query "azuread_user_sspr_enabled" {
  sql = <<-EOQ
    select
      tenant_id || '/' || id as resource,
      case
        when allowed_to_use_sspr then 'ok'
        else 'alarm'
      end as status,
      case
        when allowed_to_use_sspr then tenant_id || ' has self-service password reset enabled.'
        else tenant_id || ' has self-service password reset disabled.'
      end as reason
      ${local.common_dimensions_sql}
    from
      azuread_authorization_policy;
  EOQ
}

query "microsift_user_mfa_capable" {
  sql = <<-EOQ
    select
      id as resource,
      case
        when is_mfa_capable then 'ok'
        else 'alarm'
      end as status,
      case
        when is_mfa_capable then title || ' is MFA capable.'
        else title || ' is MFA not capable.'
      end as reason
     -- ${local.common_dimensions_sql}
    from
      microsoft365_user;
  EOQ
}