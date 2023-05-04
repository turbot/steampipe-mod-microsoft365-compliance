locals {
  cis_v200_5_common_tags = merge(local.cis_v200_common_tags, {
    cis_section_id = "5"
  })
}

benchmark "cis_v200_5" {
  title         = "5 Auditing"
  documentation = file("./cis_v200/docs/cis_v200_5.md")
  children = [
    control.cis_v200_5_2,
    control.cis_v200_5_4,
    control.cis_v200_5_10,
    control.cis_v200_5_15
  ]

  tags = merge(local.cis_v200_5_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v200_5_2" {
  title         = "5.2 Ensure Microsoft 365 audit log search is Enabled"
  description   = "When audit log search is enabled in the Microsoft Purview compliance portal, user and admin activity within the organization is recorded in the audit log and retained for 90 days. However, some organizations may prefer to use a third-party security information and event management (SIEM) application to access their auditing data. In this scenario, a global admin can choose to turn off audit log search in Microsoft 365"
  query         = query.azuread_audit_log_search_enabled
  documentation = file("./cis_v200/docs/cis_v200_5_2.md")

  tags = merge(local.cis_v200_5_common_tags, {
    cis_item_id           = "5.2"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v200_5_4" {
  title         = "5.3 Ensure the Azure AD 'Risky sign-ins' report is reviewed at least weekly"
  description   = "This report contains records of accounts that have had activity that could indicate they are compromised, such as accounts that have: -successfully signed in after multiple failures, which is an indication that the accounts have cracked passwords -signed in to tenant from a client IP address that has been recognized by Microsoft as an anonymous proxy IP address (such as a TOR network) -successful sign-ins from users where two sign-ins appeared to originate from different regions and the time between sign-ins makes it impossible for the user to have traveled between those regions"
  query         = query.azuread_risky_sign_ins_report
  documentation = file("./cis_v200/docs/cis_v200_5_4.md")

  tags = merge(local.cis_v200_5_common_tags, {
    cis_item_id           = "5.4"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v200_5_10" {
  title         = "5.10 Ensure the Account Provisioning Activity report is reviewed at least weekly"
  description   = "The Account Provisioning Activity report details any account provisioning that was attempted by an external application."
  query         = query.azuread_account_provisioning_activity_report_reviewed
  documentation = file("./cis_v200/docs/cis_v200_5_10.md")

  tags = merge(local.cis_v200_5_common_tags, {
    cis_item_id           = "5.10"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v200_5_15" {
  title         = "5.15 Ensure Guest Users are reviewed at least biweekly"
  description   = "Guest users can be set up for those users not in the organization to still be granted access to resources. It is important to maintain visibility for what guest users are established in the tenant. Ensure Guest Users are reviewed no less frequently than biweekly."
  query         = query.azuread_guest_user_info
  documentation = file("./cis_v200/docs/cis_v200_5_15.md")

  tags = merge(local.cis_v200_5_common_tags, {
    cis_item_id           = "5.15"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}
