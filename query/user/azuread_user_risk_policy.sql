with block_legacy_authentication as (
  select
    tenant_id,
    count(*)
  from
    azuread_conditional_access_policy
  where
    users->'includeUsers' ?& array['All']
    and jsonb_array_length(users -> 'excludeUsers') = 0
    and jsonb_array_length(user_risk_levels) != 0
    and applications->'includeApplications' ?& array['All']
    and jsonb_array_length(applications -> 'excludeApplications') = 0
    and built_in_controls ?& array['passwordChange']
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
  -- Required columns
  id as resource,
  case
    when (select count from block_legacy_authentication where tenant_id = t.tenant_id) > 0 then 'ok'
    else 'alarm'
  end as status,
  case
    when (select count from block_legacy_authentication where tenant_id = t.tenant_id) > 0 then display_name || ' has user risk policies enabled.'
    else display_name || ' has user risk policies disabled.'
  end as reason,
  -- Additional Dimensions
  tenant_id
from
  tenant_list as t;