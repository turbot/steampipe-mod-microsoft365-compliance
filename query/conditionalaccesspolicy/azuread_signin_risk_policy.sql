with block_legacy_authentication as (
  select
    tenant_id,
    count(*)
  from
    azuread_conditional_access_policy
  where
    users->'includeUsers' ?& array['All'] and
    jsonb_array_length(users -> 'excludeUsers') = 0 and
    jsonb_array_length(sign_in_risk_levels) != 0 and
    applications->'includeApplications' ?& array['All'] and
    jsonb_array_length(applications -> 'excludeApplications') = 0 and
    built_in_controls ?& array['mfa']
  group by
    tenant_id
),
tenant_list as (
  select
    distinct on (tenant_id) tenant_id,
    display_name,
    id
  from
    azuread_user
)
select
  -- Required Columns
  id as resource,
  case
    when (select count from block_legacy_authentication where tenant_id = t.tenant_id) > 0 then 'ok'
    else 'alarm'
  end as status,
  case
    when (select count from block_legacy_authentication where tenant_id = t.tenant_id) > 0 then t.display_name || ' has sign-in risk policies enabled.'
    else t.display_name || ' has sign-in risk policies disabled.'
  end as reason,
  -- Additional Dimensions
  tenant_id
from
  tenant_list as t;