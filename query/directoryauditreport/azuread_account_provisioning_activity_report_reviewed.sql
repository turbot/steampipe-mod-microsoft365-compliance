select
  -- Required Columns
  id as resource,
  'info' as status,
  initiated_by -> 'user' ->> 'userPrincipalName' || ' was added on ' || date_trunc('day', activity_Date_Time)::date || '.' as reason,
  -- Additional Dimensions
  tenant_id
from
  azuread_directory_audit_report
where
  activity_display_name = 'Add user';