locals {
  cis_v140_3_common_tags = merge(local.cis_v140_common_tags, {
    cis_section_id = "3"
  })
}

benchmark "cis_v140_3" {
  title         = "3 Data Management"
  documentation = file("./cis_v140/docs/cis_v140_3.md")
  children = [
    control.cis_v140_3_1,
    control.cis_v140_3_2,
    control.cis_v140_3_3,
    control.cis_v140_3_4,
    control.cis_v140_3_5,
    control.cis_v140_3_6,
    control.cis_v140_3_7
  ]

  tags = merge(local.cis_v140_3_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v140_3_1" {
  title         = "3.1 Ensure the customer lockbox feature is enabled"
  description   = "You should enable the Customer Lockbox feature. It requires Microsoft to get your approval for any datacenter operation that grants a Microsoft support engineer or other employee direct access to any of your data. For example, in some cases a Microsoft support engineer might need access to your Microsoft 365 content in order to help troubleshoot and fix an issue for you. Customer lockbox requests also have an expiration time, and content access is removed after the support engineer has fixed the issue."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_3_1.md")

  tags = merge(local.cis_v140_3_common_tags, {
    cis_item_id = "3.1"
    cis_level   = "2"
    cis_type    = "automated"
    license     = "E5"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_3_2" {
  title         = "3.2 Ensure SharePoint Online Information Protection policies are set up and used"
  description   = "You should set up and use SharePoint Online data classification policies on data stored in your SharePoint Online sites."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_3_2.md")

  tags = merge(local.cis_v140_3_common_tags, {
    cis_item_id = "3.2"
    cis_level   = "2"
    cis_type    = "manual"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_3_3" {
  title         = "3.3 Ensure external domains are not allowed in Skype or Teams"
  description   = "As of December 2021 the default for Teams external communication is set to 'People in my organization can communicate with Teams users whose accounts aren't managed by an organization.' This means that users can communicate with personal Microsoft accounts (e.g. Hotmail, Outlook etc.), which presents data loss / phishing / social engineering risks."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_3_3.md")

  tags = merge(local.cis_v140_3_common_tags, {
    cis_item_id = "3.3"
    cis_level   = "2"
    cis_type    = "manual"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_3_4" {
  title         = "3.4 Ensure DLP policies are enabled"
  description   = "Enabling Data Loss Prevention (DLP) policies allows Exchange Online and SharePoint Online content to be scanned for specific types of data like social security numbers, credit card numbers, or passwords."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_3_4.md")

  tags = merge(local.cis_v140_3_common_tags, {
    cis_item_id = "3.4"
    cis_level   = "1"
    cis_type    = "automated"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_3_5" {
  title         = "3.5 Ensure DLP policies are enabled for Microsoft Teams"
  description   = "Enabling Data Loss Prevention (DLP) policies for Microsoft Teams, blocks sensitive content when shared in teams or channels. Content to be scanned for specific types of data like social security numbers, credit card numbers, or passwords."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_3_5.md")

  tags = merge(local.cis_v140_3_common_tags, {
    cis_item_id = "3.5"
    cis_level   = "1"
    cis_type    = "manual"
    license     = "E5"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_3_6" {
  title         = "3.6 Ensure that external users cannot share files, folders, and sites they do not own"
  description   = "SharePoint gives users the ability to share files, folder, and site collections. Internal users can share with external collaborators, who with the right permissions, could share those to another external party."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_3_6.md")

  tags = merge(local.cis_v140_3_common_tags, {
    cis_item_id = "3.6"
    cis_level   = "2"
    cis_type    = "automated"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_3_7" {
  title         = "3.7 Ensure external file sharing in Teams is enabled for only approved cloud storage services"
  description   = "Microsoft Teams enables collaboration via file sharing. This file sharing is conducted within Teams, using SharePoint Online, by default; however, third-party cloud services are allowed as well."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_3_7.md")

  tags = merge(local.cis_v140_3_common_tags, {
    cis_item_id = "3.7"
    cis_level   = "2"
    cis_type    = "manual"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}
