select
  -- Required Columns
  tenant_id as resource,
  case
    when is_resharing_by_external_users_enabled then 'alarm'
    else 'ok'
  end as status,
  case
    when is_resharing_by_external_users_enabled then 'External users can share files, folders, and sites they do not own.'
    else 'External users cannot share files, folders, and sites they do not own.'
  end as reason,
  -- Additional Dimensions
  tenant_id
from
  microsoft365_sharepoint_setting;