select
  -- Required Columns
  tenant_id as resource,
  case
    when values @> '[{"name": "EnableBannedPasswordCheckOnPremises","value": "True"}]' and values @> '[{"name": "BannedPasswordCheckOnPremisesMode","value": "Enforce"}]' then 'ok'
    else 'alarm'
  end as status,
  case
    when values @> '[{"name": "EnableBannedPasswordCheckOnPremises","value": "True"}]' and values @> '[{"name": "BannedPasswordCheckOnPremisesMode","value": "Enforce"}]' then 'Password Protection is enabled.'
    else 'Password Protection is disabled.'
  end as reason,
  -- Additional Dimensions
  tenant_id
from
  azuread_directory_setting
where
  display_name = 'Password Rule Settings';