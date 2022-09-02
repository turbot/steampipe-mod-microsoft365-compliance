with block_legacy_authentication as (
select 
    tenant_id,
    count(*)
from 
    azuread_conditional_access_policy
where
    users->'includeUsers' ?& array['All'] and
    jsonb_array_length(users -> 'excludeUsers') = 0 and
    jsonb_array_length(user_risk_levels) != 0 and
    applications->'includeApplications' ?& array['All'] and
    jsonb_array_length(applications -> 'excludeApplications') = 0 and
    built_in_controls ?& array['passwordChange']
    -- and state="enabled"  
    group by tenant_id
),

tenant_list as (
  select distinct on (tenant_id) tenant_id from azuread_user
)

select
  tenant_id as resource,
  case
    when (select count from block_legacy_authentication where tenant_id = t.tenant_id) > 0 then 'ok'
    else 'alarm'
  end as status,
  case
    when (select count from block_legacy_authentication where tenant_id = t.tenant_id) > 0 then t.tenant_id || 'have sign-in risk policies enabled.'
    else t.tenant_id || 'doesnt have any sign-in risk policies enabled.'
  end as reason,
  tenant_id as tenant_id
from
  tenant_list as t;