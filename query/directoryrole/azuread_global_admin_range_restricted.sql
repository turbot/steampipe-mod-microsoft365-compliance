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
  group by
    role.tenant_id
)
select
  -- Required Columns
  tenant_id as resource,
  case
    when count >= 2 and count <= 4 then 'ok'
    else 'alarm'
  end as status,
    tenant_id || ' has ' || count || ' global administrators.' as reason,
  -- Additional Dimensions
  tenant_id
from
  global_administrator_counts;