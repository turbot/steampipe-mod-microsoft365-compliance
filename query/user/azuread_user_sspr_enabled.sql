select
  -- Required Columns
  p.tenant_id || '/' || p.display_name as resource,
  case
    when allowed_to_use_sspr then 'ok'
    else 'alarm'
  end as status,
  case
    when allowed_to_use_sspr then t.title || ' has self-service password reset enabled.'
    else t.title || ' has self-service password reset disabled.'
  end as reason,
  -- Additional Dimensions
  p.tenant_id
from
  azuread_authorization_policy as p,
  azure_tenant as t;