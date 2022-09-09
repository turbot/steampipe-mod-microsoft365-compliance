locals {
  cis_v140_2_common_tags = merge(local.cis_v140_common_tags, {
    cis_section_id = "2"
  })
}

benchmark "cis_v140_2" {
  title         = "2 Application Permissions"
  documentation = file("./cis_v140/docs/cis_v140_2.md")
  children = [
    control.cis_v140_2_1,
    control.cis_v140_2_2,
    control.cis_v140_2_3,
    control.cis_v140_2_4,
    control.cis_v140_2_5,
    control.cis_v140_2_6,
    control.cis_v140_2_7,
    control.cis_v140_2_8,
    control.cis_v140_2_9,
    control.cis_v140_2_10,
    control.cis_v140_2_11
  ]

  tags = merge(local.cis_v140_2_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v140_2_1" {
  title         = "2.1 Ensure third party integrated applications are not allowed"
  description   = "Do not allow third party integrated applications to connect to your services."
  sql           = query.ad_third_party_application_not_allowed.sql
  documentation = file("./cis_v140/docs/cis_v140_2_1.md")

  tags = merge(local.cis_v140_2_common_tags, {
    cis_item_id = "2.1"
    cis_level   = "2"
    cis_type    = "manual"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_2_2" {
  title         = "2.2 Ensure calendar details sharing with external users is disabled"
  description   = "You should not allow your users to share the full details of their calendars with external users."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_2_2.md")

  tags = merge(local.cis_v140_2_common_tags, {
    cis_item_id = "2.2"
    cis_level   = "2"
    cis_type    = "automated"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_2_3" {
  title         = "2.3 Ensure Safe Links for Office Applications is Enabled"
  description   = "Enabling Safe Links policy for Office applications allows URL's that existing inside of Office documents opened by Office, Office Online and Office mobile to be processed against Defender for Office time-of-click verification."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_2_3.md")

  tags = merge(local.cis_v140_2_common_tags, {
    cis_item_id = "2.3"
    cis_level   = "2"
    cis_type    = "automated"
    license     = "E5"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_2_4" {
  title         = "2.4 Ensure Safe Attachments for SharePoint, OneDrive, and Microsoft Teams is Enabled"
  description   = "Safe Attachments for SharePoint, OneDrive, and Microsoft Teams scans these services for malicious files."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_2_4.md")

  tags = merge(local.cis_v140_2_common_tags, {
    cis_item_id = "2.4"
    cis_level   = "2"
    cis_type    = "automated"
    license     = "E5"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_2_5" {
  title         = "2.5 Ensure Office 365 SharePoint infected files are disallowed for download"
  description   = "By default SharePoint online allows files that Defender for Office 365 has detected as infected to be downloaded."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_2_5.md")

  tags = merge(local.cis_v140_2_common_tags, {
    cis_item_id = "2.5"
    cis_level   = "2"
    cis_type    = "automated"
    license     = "E5"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_2_6" {
  title         = "2.6 Ensure user consent to apps accessing company data on their behalf is not allowed"
  description   = "By default, users can consent to applications accessing your organization's data, although only for some permissions. For example, by default a user can consent to allow an app to access their own mailbox or the Teams conversations for a team the user owns, but cannot consent to allow an app unattended access to read and write to all SharePoint sites in your organization. Do not allow users to grant consent to apps accessing company data on their behalf."
  sql           = query.ad_authorization_policy_accessing_company_data_not_allowed.sql
  documentation = file("./cis_v140/docs/cis_v140_2_6.md")

  tags = merge(local.cis_v140_2_common_tags, {
    cis_item_id = "2.6"
    cis_level   = "2"
    cis_type    = "automated"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_2_7" {
  title         = "2.7 Ensure the admin consent workflow is enabled"
  description   = "Without an admin consent workflow (Preview), a user in a tenant where user consent is disabled will be blocked when they try to access any app that requires permissions to access organizational data. The user sees a generic error message that says they're unauthorized to access the app and they should ask their admin for help."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_2_7.md")

  tags = merge(local.cis_v140_2_common_tags, {
    cis_item_id = "2.7"
    cis_level   = "2"
    cis_type    = "automated"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_2_8" {
  title         = "2.8 Ensure users installing Outlook add-ins is not allowed"
  description   = "By default, users can install add-ins in their Microsoft Outlook Desktop client, allowing data access within the client application. Do not allow users to install add-ins in Outlook."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_2_8.md")

  tags = merge(local.cis_v140_2_common_tags, {
    cis_item_id = "2.8"
    cis_level   = "2"
    cis_type    = "automated"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_2_9" {
  title         = "2.9 Ensure users installing Word, Excel, and PowerPoint add-ins is not allowed"
  description   = "By default, users can install add-ins in their Microsoft Word, Excel, and PowerPoint applications, allowing data access within the application. Do not allow users to install add-ins in Word, Excel, or PowerPoint."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_2_9.md")

  tags = merge(local.cis_v140_2_common_tags, {
    cis_item_id = "2.9"
    cis_level   = "1"
    cis_type    = "manual"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_2_10" {
  title         = "2.10 Ensure internal phishing protection for Forms is enabled"
  description   = "Microsoft Forms can be used for phishing attacks by asking personal or sensitive information and collecting the results. Microsoft 365 has built-in protection that will proactively scan for phishing attempt in forms such personal information request."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_2_10.md")

  tags = merge(local.cis_v140_2_common_tags, {
    cis_item_id = "2.10"
    cis_level   = "1"
    cis_type    = "manual"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_2_11" {
  title         = "2.11 Ensure that Sways cannot be shared with people outside of your organization"
  description   = "Disable external sharing of Sway items such as reports, newsletters, presentations etc that could contain sensitive information."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_2_11.md")

  tags = merge(local.cis_v140_2_common_tags, {
    cis_item_id = "2.11"
    cis_level   = "1"
    cis_type    = "manual"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}
