locals {
  cis_v140_5_common_tags = merge(local.cis_v140_common_tags, {
    cis_section_id = "5"
  })
}

benchmark "cis_v140_5" {
  title         = "5 Auditing"
  documentation = file("./cis_v140/docs/cis_v140_5.md")
  children = [
    control.cis_v140_5_1,
    control.cis_v140_5_3,
    control.cis_v140_5_10,
    control.cis_v140_5_15
  ]

  tags = merge(local.cis_v140_5_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v140_5_1" {
  title         = "5.1 Ensure Microsoft 365 audit log search is Enabled"
  description   = "When audit log search in the Microsoft 365 Security & Compliance Center is enabled, user and admin activity from your organization is recorded in the audit log and retained for 90 days. However, your organization might be using a third-party security information and event management (SIEM) application to access your auditing data. In that case, a global admin can turn off audit log search in Microsoft 365."
  sql           = query.azuread_audit_log_search_enabled.sql
  documentation = file("./cis_v140/docs/cis_v140_5_1.md")

  tags = merge(local.cis_v140_5_common_tags, {
    cis_item_id           = "5.1"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_5_3" {
  title         = "5.3 Ensure the Azure AD 'Risky sign-ins' report is reviewed at least weekly"
  description   = "This report contains records of accounts that have had activity that could indicate they are compromised, such as accounts that have: -successfully signed in after multiple failures, which is an indication that the accounts have cracked passwords -signed in to your tenancy from a client IP address that has been recognized by Microsoft as an anonymous proxy IP address (such as a TOR network) -successful signins from users where two signins appeared to originate from different regions and the time between signins makes it impossible for the user to have traveled between those regions"
  sql           = query.azuread_risky_sign_ins_report.sql
  documentation = file("./cis_v140/docs/cis_v140_5_3.md")

  tags = merge(local.cis_v140_5_common_tags, {
    cis_item_id           = "5.3"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_5_10" {
  title         = "5.10 Ensure the Account Provisioning Activity report is reviewed at least weekly"
  description   = "The Account Provisioning Activity report details any account provisioning that was attempted by an external application."
  sql           = query.azuread_account_provisioning_activity_report_reviewed.sql
  documentation = file("./cis_v140/docs/cis_v140_5_10.md")

  tags = merge(local.cis_v140_5_common_tags, {
    cis_item_id           = "5.10"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_5_15" {
  title         = "5.15 Ensure Guest Users are reviewed at least biweekly"
  description   = "Guest users can be set up for those users not in your tenant to still be granted access to resources. It is important to maintain visibility for what guest users are established in the tenant."
  sql           = query.azuread_guest_user_info.sql
  documentation = file("./cis_v140/docs/cis_v140_5_15.md")

  tags = merge(local.cis_v140_5_common_tags, {
    cis_item_id           = "5.15"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}
