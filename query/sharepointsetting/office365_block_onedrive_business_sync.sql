-- Block OneDrive for Business sync from unmanaged devices
select
  -- Required Columns
  tenant_id as resource,
  case
    when jsonb_array_length(allowed_domain_guids_for_sync_app) >= 1 then 'ok'
    else 'alarm'
  end as status,
  case
    when jsonb_array_length(allowed_domain_guids_for_sync_app) >= 1 then 'Allow onedrive for business sync from unmanaged devices.'
    else 'Block onedrive for business sync from unmanaged devices.'
  end as reason,
  -- Additional Dimensions
  tenant_id
from
  office365_sharepoint_setting;
