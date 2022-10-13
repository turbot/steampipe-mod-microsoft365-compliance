select
  -- Required Columns
  t.tenant_id || '/' || a.display_name as resource,
  case
    when not is_enabled then 'ok'
    else 'alarm'
  end as status,
  case
    when not is_enabled then t.title || ' has Security Defaults disabled.'
    else t.title || ' has Security Defaults enabled.'
  end as reason,
  -- Additional Dimensions
  a.tenant_id
from
  azuread_security_defaults_policy as a,
  azure_tenant as t;