locals {
  cis_v150_2_common_tags = merge(local.cis_v150_common_tags, {
    cis_section_id = "2"
  })
}

benchmark "cis_v150_2" {
  title         = "2 Application Permissions"
  documentation = file("./cis_v150/docs/cis_v150_2.md")
  children = [
    control.cis_v150_2_1,
    control.cis_v150_2_2,
    control.cis_v150_2_6,
    control.cis_v150_2_7
  ]

  tags = merge(local.cis_v150_2_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v150_2_1" {
  title         = "2.1 Ensure third party integrated applications are not allowed"
  description   = "Do not allow third party integrated applications to connect to your services."
  query         = query.azuread_third_party_application_not_allowed
  documentation = file("./cis_v150/docs/cis_v150_2_1.md")

  tags = merge(local.cis_v150_2_common_tags, {
    cis_item_id           = "2.1"
    cis_level             = "2"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v150_2_2" {
  title         = "2.2 Ensure calendar details sharing with external users is disabled"
  description   = "You should not allow your users to share the full details of their calendars with external users."
  query         = query.microsoft365_calendar_sharing_disabled
  documentation = file("./cis_v150/docs/cis_v150_2_2.md")

  tags = merge(local.cis_v150_2_common_tags, {
    cis_item_id           = "2.2"
    cis_level             = "2"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v150_2_6" {
  title         = "2.6 Ensure user consent to apps accessing company data on their behalf is not allowed"
  description   = "By default, users can consent to applications accessing your organization's data, although only for some permissions. For example, by default a user can consent to allow an app to access their own mailbox or the Teams conversations for a team the user owns, but cannot consent to allow an app unattended access to read and write to all SharePoint sites in your organization. Do not allow users to grant consent to apps accessing company data on their behalf."
  query         = query.azuread_authorization_policy_accessing_company_data_not_allowed
  documentation = file("./cis_v150/docs/cis_v150_2_6.md")

  tags = merge(local.cis_v150_2_common_tags, {
    cis_item_id           = "2.6"
    cis_level             = "2"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v150_2_7" {
  title         = "2.7 Ensure the admin consent workflow is enabled"
  description   = "Without an admin consent workflow (Preview), a user in a tenant where user consent is disabled will be blocked when they try to access any app that requires permissions to access organizational data. The user sees a generic error message that says they're unauthorized to access the app and they should ask their admin for help."
  query         = query.azuread_admin_consent_workflow_enabled
  documentation = file("./cis_v150/docs/cis_v150_2_7.md")

  tags = merge(local.cis_v150_2_common_tags, {
    cis_item_id            = "2.7"
    cis_level              = "2"
    cis_type               = "automated"
    lmicrosoft_365_license = "E3"
    service                = "Azure/ActiveDirectory"
  })
}
