with users_having_admin_roles as (
  select
    array_agg(role_template_id) as rid
  from
    azuread_directory_role
  where
    display_name like '%Administrator'
),
policy_with_mfa as (
  select
    tenant_id,
    count(p.*)
  from
    azuread_conditional_access_policy as p,
    users_having_admin_roles as a
  where
    p.built_in_controls ?& array['mfa']
    and (p.users -> 'includeRoles')::jsonb ?| (a.rid)
    and jsonb_array_length(p.users -> 'excludeUsers') < 1
  group by
    tenant_id
),
tenant_list as (
  select
    distinct on (tenant_id) tenant_id,
    display_name
  from
    azuread_user
)
select
  -- Required Columns
  tenant_id as resource,
  case
    when (select count from policy_with_mfa where tenant_id = t.tenant_id) > 0 then 'ok'
    else 'alarm'
  end as status,
  case
    when (select count from policy_with_mfa where tenant_id = t.tenant_id) > 0 then tenant_id || ' MFA enabled for all users in administrative roles.'
    else tenant_id || ' MFA disabled for all users in administrative roles.'
  end as reason,
  -- Additional Dimensions
  tenant_id
from
  tenant_list as t;