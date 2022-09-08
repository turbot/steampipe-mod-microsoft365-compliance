-- Block OneDrive for Business sync from unmanaged devices
select
  -- Required columns
  tenant_id as resource,
  case
    when jsonb_array_length(allowed_domain_guids_for_sync_app) >= 1 then 'ok'
    else 'alarm'
  end as status,
  case
     when jsonb_array_length(allowed_domain_guids_for_sync_app) >= 1 then 'allow onedrive for business sync from unmanaged devices.'
     else 'block onedrive for business sync from unmanaged devices.'
  end as reason,
  -- Additional Dimensions
  tenant_id as tenant,
  allowed_domain_guids_for_sync_app
from  
  office365_sharepoint_setting;