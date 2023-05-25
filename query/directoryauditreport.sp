query "azuread_account_provisioning_activity_report_reviewed" {
  sql = <<-EOQ
    select
      id as resource,
      'info' as status,
      initiated_by -> 'user' ->> 'userPrincipalName' || ' was added on ' || date_trunc('day', activity_Date_Time)::date || '.' as reason
      ${local.common_dimensions_sql}
    from
      azuread_directory_audit_report
    where
      activity_display_name = 'Add user';
  EOQ
}

query "azuread_audit_log_search_enabled" {
  sql = <<-EOQ
    with audit_count as (
      select
        tenant_id,
        count(id)
      from
        azuread_directory_audit_report
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
        when a.count > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when a.count > 0 then t.tenant_id || ' has audit log search enabled.'
        else t.tenant_id || ' has audit log search disabled.'
      end as reason
      ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "t.")}
    from
      tenant_list as t
      left join audit_count as a on t.tenant_id = a.tenant_id;
  EOQ
}