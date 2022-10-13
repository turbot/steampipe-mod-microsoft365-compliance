select
  -- Required Columns
  p.tenant_id || '/' || p.title as resource,
  case
    when is_enabled then 'ok'
    else 'alarm'
  end as status,
  case
    when is_enabled then a.title || ' has Admin Consent Workflow enabled.'
    else a.title || ' has Admin Consent Workflow disabled.'
  end as reason,
  -- Additional Dimensions
  p.tenant_id
from
  azuread_admin_consent_request_policy as p,
  azure_tenant as a;