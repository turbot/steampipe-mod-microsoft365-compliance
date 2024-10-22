query "microsoft365_calendar_sharing_disabled" {
  sql = <<-EOQ
    select
      id as resource,
      case
        when permissions @> '[{"isInsideOrganization":true}]' then 'ok'
        else 'alarm'
      end as status,
      case
        when permissions @> '[{"isInsideOrganization":true}]' then title || ' details sharing with external users disabled.'
        else title || ' details sharing with external users enabled.'
      end as reason
      ${local.common_dimensions_sql}
    from
      microsoft365_my_calendar;
  EOQ
}