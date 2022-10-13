select
  -- Required Columns
  tenant_id || '/' || id as resource,
  case
    when jsonb_array_length(default_user_role_permissions -> 'permissionGrantPoliciesAssigned') = 0 then 'ok'
    else 'alarm'
  end as status,
  case
    when jsonb_array_length(default_user_role_permissions -> 'permissionGrantPoliciesAssigned') = 0 then tenant_id || ' which is ' || lower(split_part(description, '.', 1)) || ' does not have Permission Grant Policies assigned.'
    else tenant_id || ' which is ' || lower(split_part(description, '.', 1)) || ' have Permission Grant Policies assigned.'
  end as reason,
  -- Additional Dimensions
  tenant_id
from
  azuread_authorization_policy;