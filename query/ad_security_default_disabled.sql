select
  -- Required Columns
  id as resource,
  case
    when is_enabled then 'alarm'
    else not is_enabled then 'ok'
  end status,
  case
    when is_enabled then 'Security Defaults is enabled.'
    else not is_enabled then 'Security Defaults is disabled.'
  end reason,
  -- Additional Dimensions
  tenant_id as tenant
from
    azuread_security_defaults_policy;