select
  -- Required Columns
  tenant_id || '/adminRequestConsentPolicy' as resource,
  case
    when is_enabled then 'ok'
    else 'alarm'
  end as status,
  case
    when is_enabled then tenant_id || ' has Admin Consent Workflow enabled.'
    else tenant_id || ' has Admin Consent Workflow disabled.'
  end as reason,
  -- Additional Dimensions
  tenant_id
from
  azuread_admin_consent_request_policy;