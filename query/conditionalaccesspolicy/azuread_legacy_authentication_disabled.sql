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
),
tenant_list as(
  select
    distinct on(tenant_id) tenant_id,
    display_name,
    id
  from
    azuread_user
)
select
  -- Required Columns
  id as resource,
  case
    when (select count from block_legacy_authentication where tenant_id=t.tenant_id) > 0 then 'ok'
    else 'alarm'
  end as status,
  case
    when (select count from block_legacy_authentication where tenant_id=t.tenant_id) > 0 then display_name || ' has Conditional Access policies enabled.'
    else display_name || ' has Conditional Access policies disabled.'
  end as reason,
  -- Additional Dimensions
  tenant_id
from
  tenant_list as t;