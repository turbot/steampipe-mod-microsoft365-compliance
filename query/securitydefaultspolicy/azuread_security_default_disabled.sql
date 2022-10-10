select
  -- Required Columns
  id as resource,
  case
    when not is_enabled then 'ok'
    else 'alarm'
  end as status,
  case
    when not is_enabled then tenant_id || ' Security Defaults is disabled.'
    else tenant_id || ' Security Defaults is enabled.'
  end as reason,
  -- Additional Dimensions
  tenant_id
from
  azuread_security_defaults_policy;