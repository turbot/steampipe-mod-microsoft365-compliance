select
  -- Required Columns
  id as resource,
  case
    when is_enabled and jsonb_array_length(reviewers) > 0 then 'ok'
    else 'alarm'
  end status,
  case
    when is_enabled and jsonb_array_length(reviewers) > 0 then 'admin consent workflow is enabled.'
    else 'admin consent workflow is disabled.'
  end reason,
  -- Additional Dimensions
  tenant_id as tenant
from
   azuread_admin_consent_request_policy;
  