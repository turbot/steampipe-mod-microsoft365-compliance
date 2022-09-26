-- Ensure calendar details sharing with external users is disabled
select
  -- Required columns
  user_identifier as resource,
  case
    when permissions @> '[{"isInsideOrganization":true}]' then 'ok'
    else 'alarm'
  end as status,
  case
     when permissions @> '[{"isInsideOrganization":true}]' then 'The calendar details sharing with external users is disabled.'
     else 'The calendar details sharing with external users is enabled.'
  end as reason,
  -- Additional Dimensions
  tenant_id as tenant
from
  office365_my_calendar;