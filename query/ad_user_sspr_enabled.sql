-- Ensure self-service password reset is enabled
select
  -- Required columns
  tenant_id as resource,
  case
    when allowed_to_use_sspr then 'ok'
    else 'alarm'
  end as status,
  case
     when allowed_to_use_sspr then 'self-service password reset is enabled.'
     else 'self-service password reset is not enabled.'
  end as reason,
  -- Additional Dimensions
  tenant_id as tenant
from
  azuread_authorization_policy;