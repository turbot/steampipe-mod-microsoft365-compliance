select 
  -- Required Columns
  id as resource,
  case
    when user_type !='Member' 
  then 'skip'
    when password_policies like '%DisablePasswordExpiration%' 
  then 'ok'
    else 'alarm'
  end as status,
  case 
    when user_type !='Member' 
  then display_name || ' is ' || user_type || ' user.'
    when password_policies like '%DisablePasswordExpiration%' 
  then display_name || ' password expiration disabled.'
    else display_name || ' password expiration enabled.'
  end as reason,
  -- Additional Dimensions
  tenant_id
from 
  azuread_user;