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

query "azuread_users_cannot_create_security_groups" {
  sql = <<-EOQ
    select
      tenant_id || '/' || id as resource,
      case
        when not (default_user_role_permissions -> 'allowedToCreateSecurityGroups')::bool then 'ok'
        else 'alarm'
      end as status,
      case
        when not (default_user_role_permissions -> 'allowedToCreateSecurityGroups')::bool then tenant_id || ' has users cannot create security groups.'
        else tenant_id || ' has users can create security groups.'
      end as reason
      ${local.common_dimensions_sql}
    from
      azuread_authorization_policy;
  EOQ
}

query "azuread_bitlocker_recovery_restricted" {
  sql = <<-EOQ
    select
      tenant_id || '/' || id as resource,
      case
        when (default_user_role_permissions -> 'allowedToReadBitlockerKeysForOwnedDevice') is null then 'alarm'
        when not (default_user_role_permissions -> 'allowedToReadBitlockerKeysForOwnedDevice')::bool then 'ok'
        else 'alarm'
      end as status,
      case
        when (default_user_role_permissions -> 'allowedToReadBitlockerKeysForOwnedDevice') is null then tenant_id || ' has BitLocker key recovery setting not configured (needs to be explicitly set to restrict users).'
        when not (default_user_role_permissions -> 'allowedToReadBitlockerKeysForOwnedDevice')::bool then tenant_id || ' has users restricted from recovering BitLocker keys.'
        else tenant_id || ' has users allowed to recover BitLocker keys.'
      end as reason
      ${local.common_dimensions_sql}
    from
      azuread_authorization_policy;
  EOQ
}