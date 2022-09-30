select
  -- Required Columns
  id as resource,
  case
    when not is_enabled then 'ok'
    else 'alarm'
  end as status,
  case
    when not is_enabled then 'Security Default is disabled.'
    else 'Security Default is enabled.'
  end as reason,
  -- Additional Dimensions
  tenant_id as tenant
from
  azuread_security_defaults_policy;
