select
  -- Required Columns
  tenant_id || '/' || id as resource,
  case
    when allowed_to_use_sspr then 'ok'
    else 'alarm'
  end as status,
  case
    when allowed_to_use_sspr then tenant_id || ' has self-service password reset enabled.'
    else tenant_id || ' has self-service password reset disabled.'
  end as reason,
  -- Additional Dimensions
  tenant_id
from
  azuread_authorization_policy;