locals {
  cis_v200_2_common_tags = merge(local.cis_v200_common_tags, {
    cis_section_id = "2"
  })
}

benchmark "cis_v200_2" {
  title         = "2 Application Permissions"
  documentation = file("./cis_v200/docs/cis_v200_2.md")
  children = [
    control.cis_v200_2_1,
    control.cis_v200_2_2,
    control.cis_v200_2_3,
    control.cis_v200_2_7
  ]

  tags = merge(local.cis_v200_2_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v200_2_1" {
  title         = "2.1 Ensure the admin consent workflow is enabled"
  description   = "The admin consent workflow gives admins a secure way to grant access to applications that require admin approval. When a user tries to access an application but is unable to provide consent, they can send a request for admin approval. The request is sent via email to admins who have been designated as reviewers. A reviewer takes action on the request, and the user is notified of the action."
  query         = query.azuread_admin_consent_workflow_enabled
  documentation = file("./cis_v200/docs/cis_v200_2_1.md")

  tags = merge(local.cis_v200_2_common_tags, {
    cis_item_id           = "2.1"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v200_2_2" {
  title         = "2.2 Ensure third party integrated applications are not allowed"
  description   = "App registrations allows users to register custom-developed applications for use within the directory."
  query         = query.azuread_third_party_application_not_allowed
  documentation = file("./cis_v200/docs/cis_v200_2_2.md")

  tags = merge(local.cis_v140_2_common_tags, {
    cis_item_id           = "2.2"
    cis_level             = "2"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v200_2_3" {
  title         = "2.3 Ensure 'External sharing' of calendars is not available"
  description   = "External calendar sharing allows an administrator to enable the ability for users to share calendars with anyone outside of the organization. Outside users will be sent a URL that can be used to view the calendar."
  query         = query.microsoft365_calendar_sharing_disabled
  documentation = file("./cis_v200/docs/cis_v200_2_3.md")

  tags = merge(local.cis_v200_2_common_tags, {
    cis_item_id           = "2.3"
    cis_level             = "2"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v200_2_7" {
  title         = "2.7 Ensure user consent to apps accessing company data on their behalf is not allowed"
  description   = "Control when end users and group owners are allowed to grant consent to applications, and when they will be required to request administrator review and approval. Allowing users to grant apps access to data helps them acquire useful applications and be productive, but can represent a risk in some situations if it's not monitored and controlled carefully."
  query         = query.azuread_authorization_policy_accessing_company_data_not_allowed
  documentation = file("./cis_v200/docs/cis_v200_2_7.md")

  tags = merge(local.cis_v200_2_common_tags, {
    cis_item_id           = "2.7"
    cis_level             = "2"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}
