select
  -- Required Columns
  tenant_id || '/' || id as resource,
  case
    when not is_enabled then 'ok'
    else 'alarm'
  end as status,
  case
    when not is_enabled then tenant_id || ' has security defaults disabled.'
    else tenant_id || ' has security defaults enabled.'
  end as reason,
  -- Additional Dimensions
  tenant_id
from
  azuread_security_defaults_policy;
