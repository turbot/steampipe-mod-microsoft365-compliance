select
  -- Required Columns
  id as resource,
  case
    when not is_enabled then 'ok'
    else 'alarm'
  end status,
  case
    when not is_enabled then 'Security Defaults is disabled.'
    else 'Security Defaults is enabled.'
  end reason,
  -- Additional Dimensions
  tenant_id as tenant
from
  azuread_security_defaults_policy;