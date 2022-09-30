select
  -- Required Columns
  id as resource,
  case
    when user_type = 'Guest' then 'info'
    else 'skip'
  end as status,
  case
    when user_type = 'Guest' then display_name || ' is a guest user.'
    else display_name || ' is not a guest user.'
  end as reason,
  -- Additional Dimensions
  tenant_id
from
  azuread_user;
  