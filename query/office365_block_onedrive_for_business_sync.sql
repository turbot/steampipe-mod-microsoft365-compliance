-- Block OneDrive for Business sync from unmanaged devices
select
  -- Required columns
  tenant_id as resource,
  case
    when is_mac_sync_app_enabled then 'ok'
    else 'alarm'
  end as status,
  case
     when is_mac_sync_app_enabled then 'allow onedrive for business sync.'
     else 'block onedrive for business sync.'
  end as reason,   
  -- Additional Dimensions
  tenant_id as tenant
from  
  office365_sharepoint_setting;
