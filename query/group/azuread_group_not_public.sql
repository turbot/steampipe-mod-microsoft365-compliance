select
  -- Required Columns
  id as resource,
  case
    when visibility = 'Public' then 'alarm'
    else 'ok'
  end status,
  case
    when visibility = 'Public' then title || ' is public.'
    else title || ' is not public.'
  end reason,
  -- Additional Dimensions
  tenant_id
from
  azuread_group;