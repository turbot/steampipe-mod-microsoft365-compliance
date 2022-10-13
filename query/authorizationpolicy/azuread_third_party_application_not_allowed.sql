select
  -- Required Columns
  p.tenant_id || '/' || p.display_name as resource,
  case
    when not (default_user_role_permissions -> 'allowedToCreateApps')::bool then 'ok'
    else 'alarm'
  end as status,
  case
    when not (default_user_role_permissions -> 'allowedToCreateApps')::bool then a.title || ' has third party integrated applications not allowed.'
    else a.title || ' has third party integrated applications allowed.'
  end as reason,
  -- Additional Dimensions
  p.tenant_id
from
  azuread_authorization_policy as p,
  azure_tenant as a;