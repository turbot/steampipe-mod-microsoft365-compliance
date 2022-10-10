select
  -- Required Columns
  id as resource,
  case
    when is_enabled then 'ok'
    else 'alarm'
  end as status,
  case
    when is_enabled then tenant_id || ' admin consent workflow is enabled.'
    else tenant_id || ' admin consent workflow is disabled.'
  end as reason,
  -- Additional Dimensions
  tenant_id
from
  azuread_admin_consent_request_policy;