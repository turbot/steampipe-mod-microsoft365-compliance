query "azuread_group_not_public" {
  sql = <<-EOQ
    select
      id as resource,
      case
        when visibility = 'Public' then 'alarm'
        else 'ok'
      end status,
      case
        when visibility = 'Public' then title || ' is public.'
        else title || ' is not public.'
      end reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      azuread_group;
  EOQ
}

query "azuread_dynamic_group_for_guest_user" {
  sql = <<-EOQ
    with tenant_list as (
      select
        distinct on (tenant_id) tenant_id,
        _ctx
      from
        azuread_user
    ), dynamic_group_for_guest_user as (
      select
        count(*) as dynamic_group_for_guest_user_count,
        tenant_id
      from
        azuread_group
      where
        membership_rule = '(user.userType -eq "guest")'
        and group_types @> '[ "DynamicMembership" ]'
      group by
        tenant_id, _ctx
    )
    select
      t.tenant_id as resource,
      case
        when dynamic_group_for_guest_user_count > 0 then 'ok'
        else 'alarm'
      end status,
      case
        when dynamic_group_for_guest_user_count > 0 then t.tenant_id || ' has dynamic group for guest user.'
        else t.tenant_id || ' does not have dynamic group for guest user.'
      end reason
      ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "t.")}
    from
      tenant_list as t
      left join dynamic_group_for_guest_user as d on d.tenant_id = t.tenant_id
  EOQ
}