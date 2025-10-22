query "microsoft365_sharepoint_external_content_sharing_restricted" {
  sql = <<-EOQ
    select
      tenant_id as resource,
      case
        when sharepoint_settings ->> 'sharing_capability' = 'externalUserAndGuestSharing' then 'alarm'
        else 'ok'
      end as status,
      case
        when sharepoint_settings ->> 'sharing_capability' = 'externalUserAndGuestSharing' then title || ' microsoft365 external content sharing unrestricted.'
        else title || ' external content sharing set to ' || (sharepoint_settings ->> 'sharing_capability') || '.'
      end as reason
      ${local.common_dimensions_sql}
    from
      microsoft365_organization;
  EOQ
}

query "microsoft365_sharepoint_resharing_by_external_users_disabled" {
  sql = <<-EOQ
    select
      tenant_id as resource,
      case
        when not (sharepoint_settings -> 'is_resharing_by_external_users_enabled')::bool then 'ok'
        else 'alarm'
      end as status,
      case
        when not (sharepoint_settings -> 'is_resharing_by_external_users_enabled')::bool then title || ' SharePoint guest users cannot share items they don''t own.'
        else title || ' SharePoint guest users can share items they don''t own.'
      end as reason
      ${local.common_dimensions_sql}
    from
      microsoft365_organization;
  EOQ
}

query "microsoft365_sharepoint_external_sharing_managed_by_domain_whitelist_or_blacklist" {
  sql = <<-EOQ
    select
      tenant_id as resource,
      case
        when jsonb_array_length(sharepoint_settings -> 'sharing_allowed_domain_list') > 0  then 'ok'
        else 'alarm'
      end as status,
      case
        when jsonb_array_length(sharepoint_settings -> 'sharing_allowed_domain_list') > 0 then title || ' sharepoint external sharing is managed through domain whitelist/blacklists.'
        else title  || ' sharepoint external sharing is not managed through domain whitelist/blacklists.'
      end as reason
      ${local.common_dimensions_sql}
    from
      microsoft365_organization;
  EOQ
}