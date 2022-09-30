with users_having_admin_roles as (
  select
    array_agg(role_template_id) as rid
  from
    azuread_directory_role
  where
    display_name like '%Administrator'
),
signin_frequency_enabled as (
  select
    tenant_id,
    count(p.*)
  from
    azuread_conditional_access_policy as p,
    users_having_admin_roles as a
  where
    (p.users -> 'includeRoles')::jsonb ?| (a.rid) and
    (p.sign_in_frequency -> 'isEnabled')::bool and
    (p.persistent_browser -> 'isEnabled')::bool and
    p.persistent_browser ->> 'mode'='never' and
    p.applications -> 'includeApplications' ?& array['All'] and
    jsonb_array_length(p.applications -> 'excludeApplications') = 0 and
    jsonb_array_length(p.built_in_controls) = 1 and
    p.built_in_controls ?& array['mfa']
    and state = 'enabled'
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
    when (select count from signin_frequency_enabled where tenant_id = t.tenant_id) > 0 then 'ok'
    else 'alarm'
  end as status,
  case
    when (select count from signin_frequency_enabled where tenant_id = t.tenant_id) > 0 then  'Sign-in frequency policy enabled.'
    else 'Sign-in frequency policy disabled.'
  end as reason,
  -- Additional Dimensions
  t.display_name
from
  tenant_list as t;