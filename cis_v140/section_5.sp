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
    control.cis_v140_5_2,
    control.cis_v140_5_3,
    control.cis_v140_5_4,
    control.cis_v140_5_5,
    control.cis_v140_5_6,
    control.cis_v140_5_7,
    control.cis_v140_5_8,
    control.cis_v140_5_9,
    control.cis_v140_5_10,
    control.cis_v140_5_11,
    control.cis_v140_5_12,
    control.cis_v140_5_13,
    control.cis_v140_5_14,
    control.cis_v140_5_15,
  ]

  tags = merge(local.cis_v140_5_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v140_5_1" {
  title         = "5.1 Ensure Microsoft 365 audit log search is Enabled"
  description   = "When audit log search in the Microsoft 365 Security & Compliance Center is enabled, user and admin activity from your organization is recorded in the audit log and retained for 90 days. However, your organization might be using a third-party security information and event management (SIEM) application to access your auditing data. In that case, a global admin can turn off audit log search in Microsoft 365."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_5_1.md")

  tags = merge(local.cis_v140_5_common_tags, {
    cis_item_id           = "5.1"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_5_2" {
  title         = "5.2 Ensure mailbox auditing for all users is Enabled"
  description   = "By turning on mailbox auditing, Microsoft 365 back office teams can track logons to a mailbox as well as what actions are taken while the user is logged on. After you turn on mailbox audit logging for a mailbox, you can search the audit log for mailbox activity. Additionally, when mailbox audit logging is turned on, some actions performed by administrators, delegates, and owners are logged by default."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_5_2.md")

  tags = merge(local.cis_v140_5_common_tags, {
    cis_item_id           = "5.2"
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

control "cis_v140_5_4" {
  title         = "5.4 Ensure the Application Usage report is reviewed at least weekly"
  description   = "You should review the Application Usage report at least weekly. This report includes a usage summary for all Software As A Service (SaaS) applications that are integrated with your directory."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_5_4.md")

  tags = merge(local.cis_v140_5_common_tags, {
    cis_item_id           = "5.4"
    cis_level             = "2"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_5_5" {
  title         = "5.5 Ensure the self-service password reset activity report is reviewed at least weekly"
  description   = "The Microsoft 365 platforms allow a user to reset their password in the event they forget it. The self-service password reset activity report logs each time a user successfully resets their password this way. You should review the self-service password reset activity report at least weekly."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_5_5.md")

  tags = merge(local.cis_v140_5_common_tags, {
    cis_item_id           = "5.5"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_5_6" {
  title         = "5.6 Ensure user role group changes are reviewed at least weekly"
  description   = "User role group changes should be reviewed on a weekly basis to ensure no one has been improperly added to an administrative role."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_5_6.md")

  tags = merge(local.cis_v140_5_common_tags, {
    cis_item_id           = "5.6"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_5_7" {
  title         = "5.7 Ensure mail forwarding rules are reviewed at least weekly"
  description   = "You should review mail forwarding rules to external domains at least every week."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_5_7.md")

  tags = merge(local.cis_v140_5_common_tags, {
    cis_item_id           = "5.7"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_5_8" {
  title         = "5.8 Ensure the Mailbox Access by Non-Owners Report is reviewed at least biweekly"
  description   = "You should review the Mailbox Access by Non-Owners report at least every other week. This report shows which mailboxes have been accessed by someone other than the mailbox owner."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_5_8.md")

  tags = merge(local.cis_v140_5_common_tags, {
    cis_item_id           = "5.8"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_5_9" {
  title         = "5.9 Ensure the Malware Detections report is reviewed at least weekly"
  description   = "You should review the Malware Detections report at least weekly. This report shows specific instances of Microsoft blocking a malware attachment from reaching your users."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_5_9.md")

  tags = merge(local.cis_v140_5_common_tags, {
    cis_item_id           = "5.9"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_5_10" {
  title         = "5.10 Ensure the Account Provisioning Activity report is reviewed at least weekly"
  description   = "The Account Provisioning Activity report details any account provisioning that was attempted by an external application."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_5_10.md")

  tags = merge(local.cis_v140_5_common_tags, {
    cis_item_id           = "5.10"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_5_11" {
  title         = "5.11 Ensure non-global administrator role group assignments are reviewed at least weekly"
  description   = "You should review non-global administrator role group assignments at least every week."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_5_11.md")

  tags = merge(local.cis_v140_5_common_tags, {
    cis_item_id           = "5.11"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_5_12" {
  title         = "5.12 Ensure the spoofed domains report is review weekly"
  description   = "Use spoof intelligence in the Security Center on the Anti-spam settings page to review all senders who are spoofing either domains that are part of your organization, or spoofing external domains. Spoof intelligence is available as part of Office 365 Enterprise E5 or separately as part of Defender for Office 365 and as of October, 2018 Exchange Online Protection (EOP)."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_5_12.md")

  tags = merge(local.cis_v140_5_common_tags, {
    cis_item_id           = "5.12"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_5_13" {
  title         = "5.13 Ensure Microsoft Defender for Cloud Apps is Enabled"
  description   = "Enabling Microsoft Defender for Cloud Apps gives you insight into suspicious activity in Microsoft 365 so you can investigate situations that are potentially problematic and, if needed, take action to address security issues."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_5_13.md")

  tags = merge(local.cis_v140_5_common_tags, {
    cis_item_id           = "5.13"
    cis_level             = "2"
    cis_type              = "manual"
    microsoft_365_license = "E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_5_14" {
  title         = "5.14 Ensure the report of users who have had their email privileges restricted due to spamming is reviewed"
  description   = "Review and unblock users who have been blocked for sending too many messages marked as spam/bulk."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_5_14.md")

  tags = merge(local.cis_v140_5_common_tags, {
    cis_item_id           = "5.14"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_5_15" {
  title         = "5.15 Ensure Guest Users are reviewed at least biweekly"
  description   = "Guest users can be set up for those users not in your tenant to still be granted access to resources. It is important to maintain visibility for what guest users are established in the tenant."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_5_15.md")

  tags = merge(local.cis_v140_5_common_tags, {
    cis_item_id           = "5.15"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}
