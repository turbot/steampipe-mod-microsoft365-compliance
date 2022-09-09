select
  -- Required Columns
  tenant_id as resource,
  case
    when count(id) > 0 then 'ok'
    else 'alarm'
  end status,
  case
    when count(id) > 0 then 'Audit log search is enabled.'
    else 'Audit log search is disabled.'
  end reason,
  -- Additional Dimensions
  tenant_id
from
  azuread_directory_audit_report;