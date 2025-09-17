query "azuread_global_admin_range_restricted" {
  sql = <<-EOQ
    with global_administrator_counts as (
      select
        role.tenant_id,
        role._ctx,
        count(*)
      from
        azuread_directory_role as role,
        jsonb_array_elements_text(member_ids) as m_id,
        azuread_user as u
      where
        u.id = m_id and role.display_name ='Global Administrator'
      group by
        role.tenant_id,
        role._ctx
    )
    select
      tenant_id as resource,
      case
        when count >= 2 and count <= 4 then 'ok'
        else 'alarm'
      end as status,
      tenant_id || ' has ' || count || ' global administrators.' as reason
      ${local.common_dimensions_sql}
    from
      global_administrator_counts;
  EOQ
}

query "azuread_microsoft_azure_management_limited_to_administrative_roles" {
  sql = <<-EOQ
    with users_having_admin_roles as (
      select
        array_agg(role_template_id) as rid
      from
        azuread_directory_role
      where
        display_name = 'Global Administrator'
    ),
    policy_with_block as (
      select
        tenant_id
      from
        azuread_conditional_access_policy as p,
        users_having_admin_roles as a
      where
        p.built_in_controls ?& array['block']
        and (p.users -> 'excludeRoles')::jsonb ?| (a.rid)
        and (p.users -> 'includeUsers')::jsonb ?& array['All']
      group by
        tenant_id
    ),
    tenant_list as (
      select
        distinct on (tenant_id) tenant_id,
        id,
        display_name,
        _ctx
      from
        azuread_user
    )
    select
      t.tenant_id as resource,
      case
        when (select count(*) from policy_with_block where tenant_id = t.tenant_id) > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when (select count(*) from policy_with_block where tenant_id = t.tenant_id) > 0 then t.tenant_id || ' limited to administrative roles.'
        else t.tenant_id || ' not limited to administrative roles.'
      end as reason
      ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "t.")}
    from
      tenant_list as t;
  EOQ
}

query "azuread_administrative_account_on_premises_sync_disabled" {
  sql = <<-EOQ
    with role_members as (
      select
        distinct jsonb_array_elements_text(member_ids) as member_id,
        title as role_title
      from
        azuread_directory_role
      where
        title like '%Administrator%'
        or title = 'Global Reader'
    )
    select
      u.user_principal_name as resource,
      case
        when u.on_premises_sync_enabled then 'alarm'
        else 'ok'
      end as status,
      case
        when u.on_premises_sync_enabled
          then u.display_name || ' is ' || rm.role_title || ' and has on-premises sync enabled'
        else u.display_name || ' is ' || rm.role_title || ' and on-premises sync is disabled'
      end as reason
    from
      role_members rm join azuread_user u on u.id = rm.member_id;
  EOQ
}

