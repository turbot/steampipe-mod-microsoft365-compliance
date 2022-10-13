with risky_sign_ins_report as (
  select
    id,
    tenant_id,
    risk_level_aggregated
  from
    azuread_sign_in_report
  where
    risk_level_aggregated = 'high'
    and created_date_time::timestamp >= (current_date - interval '7' day)
)
select
  -- Required Columns
  r.tenant_id as resource,
  'info' as status,
  case
    when count(*) < 1 then t.title || ' has no risky sign-ins reported in last week.'
    else t.title || ' has ' || count(*) || ' risky sign-ins reported in last week.'
  end as reason,
  -- Additional Dimensions
  r.tenant_id
from
  risky_sign_ins_report as r,
  azure_tenant as t
group by
  r.tenant_id,
  t.title;