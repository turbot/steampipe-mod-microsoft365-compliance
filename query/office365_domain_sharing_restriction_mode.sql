-- Ensure document sharing is being controlled by domains with whitelist or blacklist
select
  -- Required columns
  tenant_id as resource,
  case
    when sharing_domain_restriction_mode  = 'allowList' or sharing_domain_restriction_mode = 'blockList.' then 'ok'
    else 'alarm'
  end as status,
  case
     when sharing_domain_restriction_mode  = 'allowList' or sharing_domain_restriction_mode = 'blockList.' then 'document sharing is being controlled by domains with blacklist or whitelist.'
     else 'document sharing is not being controlled by domains with blacklist or whitelist.'
  end as reason,   
  -- Additional Dimensions
  tenant_id as tenant
from
  office365_sharepoint_setting;