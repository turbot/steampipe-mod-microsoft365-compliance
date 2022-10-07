select
  -- Required Columns
  user_id as resource,
  case
    when permissions @> '[{"isInsideOrganization":true}]' then 'ok'
    else 'alarm'
  end as status,
  case
    when permissions @> '[{"isInsideOrganization":true}]' then 'Calendar details sharing with external users disabled.'
    else 'Calendar details sharing with external users enabled.'
  end as reason,
  -- Additional Dimensions
  tenant_id
from
  microsoft365_my_calendar;