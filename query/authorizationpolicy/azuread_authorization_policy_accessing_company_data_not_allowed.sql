select
  -- Required Columns
  id as resource,
  case
    when jsonb_array_length(default_user_role_permissions -> 'permissionGrantPoliciesAssigned') = 0 then 'ok'
    else 'alarm'
  end as status,
  case
    when jsonb_array_length(default_user_role_permissions -> 'permissionGrantPoliciesAssigned') = 0 then display_name || ' which is ' || description || ' does not have Permission Grant Policies assigned.'
    else display_name || ' which is ' || description || ' have Permission Grant Policies assigned.'
  end as reason,
  -- Additional Dimensions
  tenant_id
from
  azuread_authorization_policy;
  