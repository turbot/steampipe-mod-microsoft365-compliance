-- Ensure modern authentication for SharePoint applications is required
select
  -- Required columns
  tenant_id as resource,
  case
    when is_legacy_auth_protocols_enabled then 'ok'
    else 'alarm'
  end as status,
  case
     when is_legacy_auth_protocols_enabled then 'authentication for sharepoint appllications is enabled.'
     else 'authentication for sharepoint appllications is not enabled.'
  end as reason,
  -- Additional Dimensions
  tenant_id as tenant
from
  office365_sharepoint_setting;