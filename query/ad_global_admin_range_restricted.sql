--  Ensure that between two and four global admins are designated.
with global_administrator_counts as (
  select
    role.tenant_id,
    count(*)
  from
    azuread_directory_role as role,
    jsonb_array_elements_text(member_ids) as m_id,
    azuread_user as u
  where
    u.id = m_id and role.display_name ='Global Administrator'
  group by role.tenant_id
)
select
  -- Required columns
  tenant_id as resource,
  case
    when count >= 2 and count <= 4 then 'ok'
    else 'alarm'
  end as status,
  case
     when count >= 2 and count <= 4 then ' global administration count is between 2 and 4 '
     else ' global administration count is either less than 2 and more than 4 '
  end as reason,   
  -- Additional Dimensions
  tenant_id as tenant
from
  global_administrator_counts;        
