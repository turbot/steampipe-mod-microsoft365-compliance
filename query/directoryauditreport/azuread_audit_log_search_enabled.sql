with audit_count as (
  select
    tenant_id,
    count(id)
  from
    azuread_directory_audit_report
  group by
    tenant_id
),
tenant_list as (
  select
    distinct on (tenant_id) tenant_id
  from
    azuread_user
)
select
  -- Required Columns
  t.tenant_id as resource,
  case
    when a.count > 0 then 'ok'
    else 'alarm'
  end as status,
  case
    when a.count > 0 then t.tenant_id || ' has audit log search enabled.'
    else t.tenant_id || ' has audit log search disabled.'
  end as reason,
  -- Additional Dimensions
  t.tenant_id
from
  tenant_list as t
  left join audit_count as a on t.tenant_id = a.tenant_id;