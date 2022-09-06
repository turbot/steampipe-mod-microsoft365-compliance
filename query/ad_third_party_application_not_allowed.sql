-- Ensure third party integrated applications are not allowed
select
  -- Required columns
  tenant_id as resource,
  case
    when default_user_role_permissions ->> 'allowedToCreateApps' = 'false' then 'ok'
    else 'alarm'
  end as status,
  case
     when default_user_role_permissions ->> 'allowedToCreateApps' = 'false' then 'third party integrated applications are not allowed.'
     else 'third party integrated applications are allowed.'
  end as reason,   
  -- Additional Dimensions
  tenant_id as tenant,
  id
from
  azuread_authorization_policy;  