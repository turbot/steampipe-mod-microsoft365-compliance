query "azuread_authorization_policy_accessing_company_data_not_allowed" {
  sql = <<-EOQ
    select
      tenant_id || '/' || id as resource,
      case
        when jsonb_array_length(default_user_role_permissions -> 'permissionGrantPoliciesAssigned') = 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when jsonb_array_length(default_user_role_permissions -> 'permissionGrantPoliciesAssigned') = 0 then tenant_id || ' which is ' || lower(split_part(description, '.', 1)) || ' does not have Permission Grant Policies assigned.'
        else tenant_id || ' which is ' || lower(split_part(description, '.', 1)) || ' have Permission Grant Policies assigned.'
      end as reason
      ${local.common_dimensions_sql}
    from
      azuread_authorization_policy;
  EOQ
}

query "azuread_third_party_application_not_allowed" {
  sql = <<-EOQ
    select
      tenant_id || '/' || id as resource,
      case
        when not (default_user_role_permissions -> 'allowedToCreateApps')::bool then 'ok'
        else 'alarm'
      end as status,
      case
        when not (default_user_role_permissions -> 'allowedToCreateApps')::bool then tenant_id || ' has third party integrated applications not allowed.'
        else tenant_id || ' has third party integrated applications allowed.'
      end as reason
      ${local.common_dimensions_sql}
    from
      azuread_authorization_policy;
  EOQ
}