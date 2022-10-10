select
  -- Required Columns
  tenant_id as resource,
  case
    when allowed_to_use_sspr then 'ok'
    else 'alarm'
  end as status,
  case
    when allowed_to_use_sspr then tenant_id || ' self-service password reset enabled.'
    else tenant_id || ' self-service password reset disabled.'
  end as reason,
  -- Additional Dimensions
  tenant_id
from
  azuread_authorization_policy;