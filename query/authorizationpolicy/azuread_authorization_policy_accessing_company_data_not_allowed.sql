select
  -- Required Columns
  p.tenant_id || '/' || p.display_name as resource,
  case
    when jsonb_array_length(default_user_role_permissions -> 'permissionGrantPoliciesAssigned') = 0 then 'ok'
    else 'alarm'
  end as status,
  case
    when jsonb_array_length(default_user_role_permissions -> 'permissionGrantPoliciesAssigned') = 0 then a.title || ' which is ' || lower(split_part(description, '.', 1)) || ' does not have Permission Grant Policies assigned.'
    else a.title || ' which is ' || lower(split_part(description, '.', 1)) || ' have Permission Grant Policies assigned.'
  end as reason,
  -- Additional Dimensions
  p.tenant_id
from
  azuread_authorization_policy as p,
  azure_tenant as a;