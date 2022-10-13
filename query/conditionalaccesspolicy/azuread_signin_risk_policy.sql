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
)
select
  -- Required Columns
  t.tenant_id as resource,
  case
    when (select count from block_legacy_authentication where tenant_id = t.tenant_id) > 0 then 'ok'
    else 'alarm'
  end as status,
  case
    when (select count from block_legacy_authentication where tenant_id = t.tenant_id) > 0 then t.title || ' has sign-in risk policies enabled.'
    else t.title || ' has sign-in risk policies disabled.'
  end as reason,
  -- Additional Dimensions
  t.tenant_id
from
  azure_tenant as t;