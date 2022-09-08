locals {
  cis_v140_6_common_tags = merge(local.cis_v140_common_tags, {
    cis_section_id = "6"
  })
}

benchmark "cis_v140_6" {
  title         = "6 Data Management"
  documentation = file("./cis_v140/docs/cis_v140_6.md")
  children = [
    control.cis_v140_6_1,
    control.cis_v140_6_2,
    control.cis_v140_6_3,
    control.cis_v140_6_4
  ]

  tags = merge(local.cis_v140_6_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v140_6_1" {
  title         = "6.1 Ensure document sharing is being controlled by domains with whitelist or blacklist"
  description   = "You should control sharing of documents to external domains by either blocking domains or only allowing sharing with specific named domains."
  sql           = query.office365_domain_sharing_restriction_mode.sql
  documentation = file("./cis_v140/docs/cis_v140_6_1.md")

  tags = merge(local.cis_v140_6_common_tags, {
    cis_item_id = "6.1"
    cis_level   = "2"
    cis_type    = "automated"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_6_2" {
  title         = "6.2 Block OneDrive for Business sync from unmanaged devices"
  description   = "You should prevent company data from OneDrive for Business from being synchronized to non-corporate managed devices."
  sql           = query.office365_block_onedrive_business_sync.sql
  documentation = file("./cis_v140/docs/cis_v140_6_2.md")

  tags = merge(local.cis_v140_6_common_tags, {
    cis_item_id = "6.2"
    cis_level   = "2"
    cis_type    = "automated"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_6_3" {
  title         = "6.3 Ensure expiration time for external sharing links is set"
  description   = "You should restrict the length of time that anonymous access links are valid."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_6_3.md")

  tags = merge(local.cis_v140_6_common_tags, {
    cis_item_id = "6.3"
    cis_level   = "1"
    cis_type    = "automated"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_6_4" {
  title         = "6.4 Ensure external storage providers available in Outlook on the Web are restricted"
  description   = "You should restrict storage providers that are integrated with Outlook on the Web."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_6_4.md")

  tags = merge(local.cis_v140_6_common_tags, {
    cis_item_id = "6.4"
    cis_level   = "2"
    cis_type    = "automated"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}
