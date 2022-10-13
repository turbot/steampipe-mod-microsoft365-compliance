select
  -- Required Columns
  tenant_id || '/' || display_name as resource,
  case
    when not (default_user_role_permissions -> 'allowedToCreateApps')::bool then 'ok'
    else 'alarm'
  end as status,
  case
    when not (default_user_role_permissions -> 'allowedToCreateApps')::bool then tenant_id || ' has third party integrated applications not allowed.'
    else tenant_id || ' has third party integrated applications allowed.'
  end as reason,
  -- Additional Dimensions
  tenant_id
from
  azuread_authorization_policy;