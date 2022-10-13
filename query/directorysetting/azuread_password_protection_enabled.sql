with enable_banned_password_check_on_premises_settings as (
  select
    tenant_id,
    id
  from
   azuread_directory_setting
  where
    display_name = 'Password Rule Settings'
    and (name = 'EnableBannedPasswordCheckOnPremises' and value = 'True')
), banned_password_check_on_premise_mode_settings as (
    select
      tenant_id,
      id
    from
    azuread_directory_setting
    where
      display_name = 'Password Rule Settings'
      and (name = 'BannedPasswordCheckOnPremisesMode' and value = 'Enforce')
)
select
  -- Required Columns
  t.tenant_id as resource,
  case
    when (e.tenant_id is not null) and (b.tenant_id is not null) then 'ok'
    else 'alarm'
  end as status,
  case
    when (e.tenant_id is not null) and (b.tenant_id is not null) then t.title || ' password protection is enabled.'
    else t.title || ' password protection is disabled.'
  end as reason,
  -- Additional Dimensions
  t.tenant_id
from
  azure_tenant as t left join
  enable_banned_password_check_on_premises_settings as e on e.tenant_id = t.tenant_id
  left join banned_password_check_on_premise_mode_settings as b on b.tenant_id = t.tenant_id;