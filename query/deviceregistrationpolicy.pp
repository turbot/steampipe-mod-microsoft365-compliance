query "azuread_device_join_restricted" {
  sql = <<-EOQ
    select
      tenant_id || '/' || id as resource,
      case
        when azure_ad_join -> 'allowedToJoin' ->> '@odata.type' = '#microsoft.graph.enumeratedDeviceRegistrationMembership'
          or azure_ad_join -> 'allowedToJoin' ->> '@odata.type' = '#microsoft.graph.noDeviceRegistrationMembership' then 'ok'
        else 'alarm'
      end as status,
      case
        when azure_ad_join -> 'allowedToJoin' ->> '@odata.type' = '#microsoft.graph.enumeratedDeviceRegistrationMembership' then tenant_id || ' has device join restricted to selected users or groups.'
        when azure_ad_join -> 'allowedToJoin' ->> '@odata.type' = '#microsoft.graph.noDeviceRegistrationMembership' then tenant_id || ' has device join restricted.'
        else tenant_id || ' has device join allowed for all users.'
      end as reason
      ${local.common_dimensions_sql}
    from
      azuread_device_registration_policy;
  EOQ
}

query "azuread_max_devices_per_user_limited" {
  sql = <<-EOQ
    select
      tenant_id || '/' || id as resource,
      case
        when user_device_quota <= 20 then 'ok'
        else 'alarm'
      end as status,
      case
        when user_device_quota <= 20 then tenant_id || ' has maximum devices per user limited to ' || user_device_quota || ' (recommended: 20 or less).'
        else tenant_id || ' has maximum devices per user set to ' || user_device_quota || ' (recommended: 20 or less).'
      end as reason
      ${local.common_dimensions_sql}
    from
      azuread_device_registration_policy;
  EOQ
}

query "azuread_ga_not_local_admin_on_join" {
  sql = <<-EOQ
    select
      tenant_id || '/' || id as resource,
      case
        when azure_ad_join -> 'localAdmins' is null then 'ok'
        when (azure_ad_join -> 'localAdmins' -> 'enableGlobalAdmins') is null then 'ok'
        when not ((azure_ad_join -> 'localAdmins' -> 'enableGlobalAdmins')::bool) then 'ok'
        else 'alarm'
      end as status,
      case
        when azure_ad_join -> 'localAdmins' is null then tenant_id || ' has Global Administrator role not added as local administrator during Entra join (setting not configured, default behavior).'
        when (azure_ad_join -> 'localAdmins' -> 'enableGlobalAdmins') is null then tenant_id || ' has Global Administrator role not added as local administrator during Entra join (enableGlobalAdmins not set).'
        when not ((azure_ad_join -> 'localAdmins' -> 'enableGlobalAdmins')::bool) then tenant_id || ' has Global Administrator role not added as local administrator during Entra join.'
        else tenant_id || ' has Global Administrator role added as local administrator during Entra join.'
      end as reason
      ${local.common_dimensions_sql}
    from
      azuread_device_registration_policy;
  EOQ
}

query "azuread_laps_enabled" {
  sql = <<-EOQ
    select
      tenant_id || '/' || id as resource,
      case
        when (local_admin_password ->> 'isEnabled')::bool = true then 'ok'
        else 'alarm'
      end as status,
      case
        when (local_admin_password ->> 'isEnabled')::bool = true then tenant_id || ' has Local Administrator Password Solution (LAPS) enabled.'
        else tenant_id || ' has Local Administrator Password Solution (LAPS) disabled.'
      end as reason
      ${local.common_dimensions_sql}
    from
      azuread_device_registration_policy;
  EOQ
}

query "azuread_local_admin_assignment_limited" {
  sql = <<-EOQ
    select
      tenant_id || '/' || id as resource,
      case
        when azure_ad_join -> 'localAdmins' is null then 'ok'
        when azure_ad_join -> 'localAdmins' -> 'registeringUsers' is null then 'ok'
        when azure_ad_join -> 'localAdmins' -> 'registeringUsers' ->> '@odata.type' = '#microsoft.graph.enumeratedDeviceRegistrationMembership'
          or azure_ad_join -> 'localAdmins' -> 'registeringUsers' ->> '@odata.type' = '#microsoft.graph.noDeviceRegistrationMembership' then 'ok'
        else 'alarm'
      end as status,
      case
        when azure_ad_join -> 'localAdmins' is null then tenant_id || ' has local administrator assignment limited during Entra join (setting not configured, default behavior).'
        when azure_ad_join -> 'localAdmins' -> 'registeringUsers' is null then tenant_id || ' has local administrator assignment limited during Entra join (registeringUsers not set).'
        when azure_ad_join -> 'localAdmins' -> 'registeringUsers' ->> '@odata.type' = '#microsoft.graph.enumeratedDeviceRegistrationMembership' then tenant_id || ' has local administrator assignment limited to selected users or groups during Entra join.'
        when azure_ad_join -> 'localAdmins' -> 'registeringUsers' ->> '@odata.type' = '#microsoft.graph.noDeviceRegistrationMembership' then tenant_id || ' has local administrator assignment disabled (none) during Entra join.'
        else tenant_id || ' has local administrator assignment allowed for all users during Entra join.'
      end as reason
      ${local.common_dimensions_sql}
    from
      azuread_device_registration_policy;
  EOQ
}

