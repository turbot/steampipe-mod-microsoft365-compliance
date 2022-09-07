  -- Ensure the Azure AD 'Risky sign-ins' report is reviewed at least weekly
with risky_sign_ins_report as (
  select
    id,
    tenant_id,
    risk_level_aggregated
  from
    azuread_sign_in_report
  where
    risk_level_aggregated = 'high' and 
    created_date_time::timestamp >= (current_date - interval '7' day)
)
select
  -- Required columns
  tenant_id as resource,
  'info' as status,
  case
     when count(*) < 1 then 'no risky sign ins reported in last week.'
     else count(*) || ' risky sign ins as reported in last week.'
  end as reason,   
  -- Additional Dimensions
  tenant_id as tenant
from  
  risky_sign_ins_report
group by 
  tenant_id;









    select id, risk_state ,created_date_time, risk_level_aggregated from azuread_sign_in_report where risk_level_aggregated = 'high' and 
    created_date_time::timestamp >= (current_date - interval '7' day)


