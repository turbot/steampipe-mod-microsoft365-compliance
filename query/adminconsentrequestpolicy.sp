query "azuread_admin_consent_workflow_enabled" {
  sql = <<-EOQ
    select
      tenant_id || '/adminConsentRequestPolicy' as resource,
      case
        when is_enabled then 'ok'
        else 'alarm'
      end as status,
      case
        when is_enabled then tenant_id || ' has Admin Consent Workflow enabled.'
        else tenant_id || ' has Admin Consent Workflow disabled.'
      end as reason
      ${local.common_dimensions_sql}
    from
      azuread_admin_consent_request_policy;
  EOQ
}