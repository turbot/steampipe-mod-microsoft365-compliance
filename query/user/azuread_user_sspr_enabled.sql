-- Ensure self-service password reset is enabled
select
  -- Required Columns
  tenant_id as resource,
  case
    when allowed_to_use_sspr then 'ok'
    else 'alarm'
  end as status,
  case
    when allowed_to_use_sspr then 'Self-service password reset enabled.'
    else 'Self-service password reset disabled.'
  end as reason,
  -- Additional Dimensions
  tenant_id
from
  azuread_authorization_policy;