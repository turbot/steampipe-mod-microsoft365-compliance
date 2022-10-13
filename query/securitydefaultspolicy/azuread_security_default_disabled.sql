select
  -- Required Columns
  tenant_id || '/' || display_name as resource,
  case
    when not is_enabled then 'ok'
    else 'alarm'
  end as status,
  case
    when not is_enabled then tenant_id || ' has Security Defaults disabled.'
    else tenant_id || ' has Security Defaults enabled.'
  end as reason,
  -- Additional Dimensions
  tenant_id
from
  azuread_security_defaults_policy;