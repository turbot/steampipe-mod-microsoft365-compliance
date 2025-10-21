query "azuread_authentication_method_microsoft_authenticator_mfa_fatigue_protection" {
  sql = <<-EOQ
    with tenant_list as (
      select distinct on (tenant_id) tenant_id, _ctx
      from azuread_user
    ),
    authentication_method_policy as (
      select
        tenant_id,
        count(*) as authentication_method_policy_count
      from
        azuread_authentication_method_policy,
        jsonb_array_elements(authentication_method_configurations) as cfg
      where
        cfg ->> 'id' = 'MicrosoftAuthenticator'
        and cfg ->> 'state' = 'enabled'
        and exists (
          select 1
          from jsonb_array_elements(cfg -> 'includeTargets') as t
          where t ->> 'id' = 'all_users'
        )
        and cfg -> 'featureSettings' -> 'numberMatchingRequiredState' ->> 'state' = 'enabled'
        and cfg -> 'featureSettings' -> 'numberMatchingRequiredState' -> 'includeTarget' ->> 'id' = 'all_users'
        and cfg -> 'featureSettings' -> 'displayAppInformationRequiredState' ->> 'state' = 'enabled'
        and cfg -> 'featureSettings' -> 'displayAppInformationRequiredState' -> 'includeTarget' ->> 'id' = 'all_users'
        and cfg -> 'featureSettings' -> 'displayLocationInformationRequiredState' ->> 'state' = 'enabled'
        and cfg -> 'featureSettings' -> 'displayLocationInformationRequiredState' -> 'includeTarget' ->> 'id' = 'all_users'
      group
        by tenant_id
    )
    select
      t.tenant_id as resource,
      case
        when authentication_method_policy_count > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when authentication_method_policy_count > 0 then t.tenant_id || ' has Microsoft Authenticator enabled and configured with number matching, application name display, and location display enforced for all users to protect against MFA fatigue.'
        else t.tenant_id || ' does not have Microsoft Authenticator fully configured with number matching, application name display, and location display for all users to protect against MFA fatigue.'
      end as reason
      ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "t.")}
    from
      tenant_list as t
      left join authentication_method_policy as p on p.tenant_id = t.tenant_id;
  EOQ
}

query "azuread_authentication_method_restrict_insecure_methods" {
  sql = <<-EOQ
    with tenant_list as (
      select distinct on (tenant_id) tenant_id, _ctx
      from azuread_user
    ),
    authentication_method_policy as (
      select
        tenant_id,
        count(*) as required_methods_enabled
      from
        azuread_authentication_method_policy,
        jsonb_array_elements(authentication_method_configurations) as cfg
      where
        cfg ->> 'id' in ('Sms', 'Voice', 'Email')
        and cfg ->> 'state' = 'enabled'
      group by tenant_id
    )
    select
      t.tenant_id as resource,
      case
        when required_methods_enabled = 3 then 'ok'
        else 'alarm'
      end as status,
      case
        when required_methods_enabled = 3 then t.tenant_id || ' has SMS, Voice call, and Email OTP authentication methods all enabled.'
        else t.tenant_id || ' does not have all of SMS, Voice call, and Email OTP authentication methods enabled.'
      end as reason
      ${replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "t.")}
    from
      tenant_list as t
      left join authentication_method_policy as p on p.tenant_id = t.tenant_id;
  EOQ
}
