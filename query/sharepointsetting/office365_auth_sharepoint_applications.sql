-- Ensure modern authentication for SharePoint applications is required
select
  -- Required Columns
  tenant_id as resource,
  case
    when is_legacy_auth_protocols_enabled then 'ok'
    else 'alarm'
  end as status,
  case
    when is_legacy_auth_protocols_enabled then 'Authentication for sharepoint appllications enabled.'
    else 'Authentication for sharepoint appllications disabled.'
  end as reason,
  -- Additional Dimensions
  tenant_id
from
  office365_sharepoint_setting;