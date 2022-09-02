select
  -- Required Columns
  id as resource,
  case
    when visibility = 'Public' then 'alarm'
    else 'ok'
  end status,
  case
    when visibility = 'Public' then display_name || ' is public.'
    else display_name || ' is not public.'
  end reason,
  -- Additional Dimensions
  tenant_id as tenant
from
  azuread_group;
  