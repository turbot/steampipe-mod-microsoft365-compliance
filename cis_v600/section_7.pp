locals {
  cis_v600_7_common_tags = merge(local.cis_v600_common_tags, {
    cis_section_id = "7"
  })
}

locals {
  cis_v600_7_2_common_tags = merge(local.cis_v600_7_common_tags, {
    cis_section_id = "7.2"
  })
}

locals {
  cis_v600_7_3_common_tags = merge(local.cis_v600_7_common_tags, {
    cis_section_id = "7.3"
  })
}

benchmark "cis_v600_7" {
  title         = "7 SharePoint admin center"
  documentation = file("./cis_v600/docs/cis_v600_7.md")
  children = [
    benchmark.cis_v600_7_2,
  ]

  tags = merge(local.cis_v600_7_common_tags, {
    type    = "Benchmark"
    service = "Microsoft365/SharePoint"
  })
}

benchmark "cis_v600_7_2" {
  title = "7.2 Policies"
  children = [
    control.cis_v600_7_2_3,
    control.cis_v600_7_2_5,
    control.cis_v600_7_2_6,
  ]

  tags = merge(local.cis_v600_7_2_common_tags, {
    type    = "Benchmark"
    service = "Microsoft365/SharePoint"
  })
}

control "cis_v600_7_2_3" {
  title         = "7.2.3 Ensure external content sharing is restricted"
  description   = "The external sharing settings govern sharing for the organization overall. Each site has its own sharing setting that can be set independently, though it must be at the same or more restrictive setting as the organization. The new and existing guests option requires people who have received invitations to sign in with their work or school account (if their organization uses Microsoft 365) or a Microsoft account, or to provide a code to verify their identity. Users can share with guests already in your organization's directory, and they can send invitations to people who will be added to the directory if they sign in. The recommended state is New and existing guests or less permissive."
  query         = query.microsoft365_sharepoint_external_content_sharing_restricted
  documentation = file("./cis_v600/docs/cis_v600_7_2_3.md")

  tags = merge(local.cis_v600_7_2_common_tags, {
    cis_item_id           = "7.2.3"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Microsoft365/SharePoint"
  })
}

control "cis_v600_7_2_5" {
  title         = "7.2.5 Ensure that SharePoint guest users cannot share items they don't own"
  description   = "SharePoint gives users the ability to share files, folders, and site collections. Internal users can share with external collaborators, and with the right permissions could share to other external parties."
  query         = query.microsoft365_sharepoint_resharing_by_external_users_disabled
  documentation = file("./cis_v600/docs/cis_v600_7_2_5.md")

  tags = merge(local.cis_v600_7_2_common_tags, {
    cis_item_id           = "7.2.5"
    cis_level             = "2"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Microsoft365/SharePoint"
  })
}

control "cis_v600_7_2_6" {
  title         = "7.2.6 Ensure SharePoint external sharing is restricted"
  description   = "The external sharing features of SharePoint and OneDrive let users in the organization share content with people outside the organization (such as partners, vendors, clients, or customers). It can also be used to share between licensed users on multiple Microsoft 365 subscriptions if your organization has more than one subscription. The recommended state is Limit external sharing by domain > Allow only specific domains"
  query         = query.microsoft365_sharepoint_external_sharing_managed_by_domain_whitelist_or_blacklist
  documentation = file("./cis_v600/docs/cis_v600_7_2_6.md")

  tags = merge(local.cis_v600_7_2_common_tags, {
    cis_item_id           = "7.2.6"
    cis_level             = "2"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Microsoft365/SharePoint"
  })
}

benchmark "cis_v600_7_3" {
  title = "7.3 Settings"
  children = [
  ]

  tags = merge(local.cis_v600_7_3_common_tags, {
    type    = "Benchmark"
    service = "Microsoft365/SharePoint"
  })
}

