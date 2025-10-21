locals {
  cis_v500_7_common_tags = merge(local.cis_v500_common_tags, {
    cis_section_id = "7"
  })
}

locals {
  cis_v500_7_2_common_tags = merge(local.cis_v500_7_common_tags, {
    cis_section_id = "7.2"
  })
}

benchmark "cis_v500_7" {
  title         = "7 SharePoint admin center"
  documentation = file("./cis_v500/docs/cis_v500_7.md")
  children = [
    benchmark.cis_v500_7_2
  ]

  tags = merge(local.cis_v500_7_common_tags, {
    type    = "Benchmark"
    service = "Microsoft365/SharePoint"
  })
}

benchmark "cis_v500_7_2" {
  title = "7.2 Policies"
  children = [
    control.cis_v500_7_2_3,
    control.cis_v500_7_2_5,
    control.cis_v500_7_2_6
  ]

  tags = merge(local.cis_v500_7_2_common_tags, {
    type    = "Benchmark"
    service = "Microsoft365/SharePoint"
  })
}

control "cis_v500_7_2_3" {
  title         = "7.2.3 Ensure external content sharing is restricted"
  description   = "The external sharing settings govern sharing for the organization overall. Each site has its own sharing setting that can be set independently, though it must be at the same or more restrictive setting as the organization."
  query         = query.microsoft365_sharepoint_external_content_sharing_restricted
  documentation = file("./cis_v500/docs/cis_v500_7_2_3.md")

  tags = merge(local.cis_v500_7_2_common_tags, {
    cis_item_id           = "7.2.3"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Microsoft365/SharePoint"
  })
}

control "cis_v500_7_2_5" {
  title         = "7.2.5 Ensure that SharePoint guest users cannot share items they don't own"
  description   = "SharePoint gives users the ability to share files, folders, and site collections. Internal users can share with external collaborators, and with the right permissions could share to other external parties."
  query         = query.microsoft365_sharepoint_resharing_by_external_users_disabled
  documentation = file("./cis_v500/docs/cis_v500_7_2_5.md")

  tags = merge(local.cis_v500_7_2_common_tags, {
    cis_item_id           = "7.2.5"
    cis_level             = "2"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Microsoft365/SharePoint"
  })
}

control "cis_v500_7_2_6" {
  title         = "7.2.6 Ensure SharePoint external sharing is managed through domain whitelist/blacklists"
  description   = "Control sharing of documents to external domains by either blocking domains or only allowing sharing with specific named domains."
  query         = query.microsoft365_sharepoint_external_sharing_managed_by_domain_whitelist_or_blacklist
  documentation = file("./cis_v500/docs/cis_v500_7_2_6.md")

  tags = merge(local.cis_v500_7_2_common_tags, {
    cis_item_id           = "7.2.6"
    cis_level             = "2"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Microsoft365/SharePoint"
  })
}
