select
  -- Required Columns
  tenant_id as resource,
  case
    when is_legacy_auth_protocols_enabled then 'ok'
    else 'alarm'
  end as status,
  case
    when is_legacy_auth_protocols_enabled then tenant_id || ' authentication for SharePoint applications enabled.'
    else tenant_id || ' authentication for SharePoint applications disabled.'
  end as reason,
  -- Additional Dimensions
  tenant_id
from
  microsoft365_sharepoint_setting;