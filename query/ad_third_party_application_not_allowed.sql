-- Ensure third party integrated applications are not allowed
select
  -- Required columns
  tenant_id as resource,
  case
    when not (default_user_role_permissions -> 'allowedToCreateApps')::bool then 'ok'
    else 'alarm'
  end as status,
  case
    when not (default_user_role_permissions -> 'allowedToCreateApps')::bool then 'Third party integrated applications are not allowed.'
    else 'Third party integrated applications are allowed.'
  end as reason,
  -- Additional Dimensions
  tenant_id as tenant,
  id
from
  azuread_authorization_policy;
