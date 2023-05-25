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