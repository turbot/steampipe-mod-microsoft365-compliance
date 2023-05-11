with users_having_admin_roles as (
  select
    array_agg(role_template_id) as rid
  from
    azuread_directory_role
  where
    display_name = 'Global Administrator'
),
policy_with_block as (
  select
    tenant_id
  from
    azuread_conditional_access_policy as p,
    users_having_admin_roles as a
  where
    p.built_in_controls ?& array['block']
    and (p.users -> 'excludeRoles')::jsonb ?| (a.rid)
    and (p.users -> 'includeUsers')::jsonb ?& array['All']
  group by
    tenant_id
),
tenant_list as (
  select
    distinct on (tenant_id) tenant_id,
    id,
    display_name
  from
    azuread_user
)
select
  -- Required Columns
  t.tenant_id as resource,
  case
    when (select count from policy_with_block where tenant_id = t.tenant_id) > 0  then 'ok'
    else 'alarm'
  end as status,
  case
    when (select count from policy_with_block where tenant_id = t.tenant_id) > 0 then t.tenant_id || ' limited to administrative roles.'
    else t.tenant_id || ' not limited to administrative roles.'
  end as reason,
  -- Additional Dimensions
  t.tenant_id
from
  tenant_list as t;