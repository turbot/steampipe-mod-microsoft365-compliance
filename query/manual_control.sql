select
  -- Required Columns
  tenant_id as resource,
  'info' as status,
  'Manual verification required.' as reason,
  -- Additional Dimensions
  display_name
from
  azure_tenant;
