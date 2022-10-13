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
),
tenant_list as (
  select
    distinct on (tenant_id) tenant_id
  from
    azuread_user
)
select
  -- Required Columns
  t.tenant_id as resource,
  case
    when (e.tenant_id is not null) and (b.tenant_id is not null) then 'ok'
    else 'alarm'
  end as status,
  case
    when (e.tenant_id is not null) and (b.tenant_id is not null) then t.tenant_id || ' has password protection enabled.'
    else t.tenant_id || ' has password protection disabled.'
  end as reason,
  -- Additional Dimensions
  t.tenant_id
from
  tenant_list as t left join
  enable_banned_password_check_on_premises_settings as e on e.tenant_id = t.tenant_id
  left join banned_password_check_on_premise_mode_settings as b on b.tenant_id = t.tenant_id;