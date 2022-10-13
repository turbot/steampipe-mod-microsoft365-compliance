with block_legacy_authentication as (
  select
    tenant_id,
    count(*)
  from
    azuread_conditional_access_policy
  where
    client_app_types ?& array['exchangeActiveSync', 'other']
    and built_in_controls ?& array['block']
    and users -> 'includeUser' ?& array['All']
    and jsonb_array_length(users -> 'excludeUser') != 0
  group by
    tenant_id
)
select
  -- Required Columns
  tenant_id as resource,
  case
    when (select count from block_legacy_authentication where tenant_id = t.tenant_id) > 0 then 'ok'
    else 'alarm'
  end as status,
  case
    when (select count from block_legacy_authentication where tenant_id = t.tenant_id) > 0 then title || ' has Conditional Access policies enabled.'
    else title || ' has Conditional Access policies disabled.'
  end as reason,
  -- Additional Dimensions
  tenant_id
from
  azure_tenant as t;