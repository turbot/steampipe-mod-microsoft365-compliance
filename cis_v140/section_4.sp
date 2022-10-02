locals {
  cis_v140_4_common_tags = merge(local.cis_v140_common_tags, {
    cis_section_id = "4"
  })
}

benchmark "cis_v140_4" {
  title         = "4 Email Security / Exchange Online"
  documentation = file("./cis_v140/docs/cis_v140_4.md")
  children = [
    control.cis_v140_4_1,
    control.cis_v140_4_2,
    control.cis_v140_4_3,
    control.cis_v140_4_4,
    control.cis_v140_4_5,
    control.cis_v140_4_6,
    control.cis_v140_4_7,
    control.cis_v140_4_8,
    control.cis_v140_4_9,
    control.cis_v140_4_10,
    control.cis_v140_4_11,
    control.cis_v140_4_12
  ]

  tags = merge(local.cis_v140_4_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v140_4_1" {
  title         = "4.1 Ensure the Common Attachment Types Filter is enabled"
  description   = "The Common Attachment Types Filter lets a user block known and custom malicious file types from being attached to emails."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_4_1.md")

  tags = merge(local.cis_v140_4_common_tags, {
    cis_item_id           = "4.1"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_4_2" {
  title         = "4.2 Ensure Exchange Online Spam Policies are set correctly"
  description   = "You should set your Exchange Online Spam Policies to copy emails and notify someone when a sender in your tenant has been blocked for sending spam emails."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_4_2.md")

  tags = merge(local.cis_v140_4_common_tags, {
    cis_item_id           = "4.2"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_4_3" {
  title         = "4.3 Ensure all forms of mail forwarding are blocked and/or disabled"
  description   = "You should set your Exchange Online mail transport rules to not forward email to domains outside of your organization. Automatic forwarding to prevent users from auto-forwarding mail via Outlook or Outlook on the web should also be disabled. Alongside this Client Rules Forwarding Block, which prevents the use of any client-side rules that forward email to an external domain, should also be enabled."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_4_3.md")

  tags = merge(local.cis_v140_4_common_tags, {
    cis_item_id           = "4.3"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_4_4" {
  title         = "4.4 Ensure mail transport rules do not whitelist specific domains"
  description   = "You should set your Exchange Online mail transport rules so they do not whitelist any specific domains."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_4_4.md")

  tags = merge(local.cis_v140_4_common_tags, {
    cis_item_id           = "4.4"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_4_5" {
  title         = "4.5 Ensure the Safe Links policy is enabled"
  description   = "Enabling the Safe Links policy allows email messages that include URLs to be processed and rewritten if required. Safe Links provides time-of-click verification of web addresses in email messages and Office documents."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_4_5.md")

  tags = merge(local.cis_v140_4_common_tags, {
    cis_item_id           = "4.5"
    cis_level             = "2"
    cis_type              = "automated"
    microsoft_365_license = "E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_4_6" {
  title         = "4.6 Ensure Safe Attachments policy is enabled"
  description   = "Enabling the Safe Attachments policy extends malware protections to include routing all messages and attachments without a known malware signature to a special hypervisor environment. In that environment, a behavior analysis is performed using a variety of machine learning and analysis techniques to detect malicious intent."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_4_6.md")

  tags = merge(local.cis_v140_4_common_tags, {
    cis_item_id           = "4.6"
    cis_level             = "2"
    cis_type              = "automated"
    microsoft_365_license = "E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_4_7" {
  title         = "4.7 Ensure that an anti-phishing policy has been created"
  description   = "By default, Office 365 includes built-in features that help protect your users from phishing attacks. Set up anti-phishing polices to increase this protection, for example by refining settings to better detect and prevent impersonation and spoofing attacks. The default policy applies to all users within the organization, and is a single view where you can fine- tune anti-phishing protection. Custom policies can be created and configured for specific users, groups or domains within the organization and will take precedence over the default policy for the scoped users."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_4_7.md")

  tags = merge(local.cis_v140_4_common_tags, {
    cis_item_id           = "4.7"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_4_8" {
  title         = "4.8 Ensure that DKIM is enabled for all Exchange Online Domains"
  description   = "You should use DKIM in addition to SPF and DMARC to help prevent spoofers from sending messages that look like they are coming from your domain."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_4_8.md")

  tags = merge(local.cis_v140_4_common_tags, {
    cis_item_id           = "4.8"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_4_9" {
  title         = "4.9 Ensure that SPF records are published for all Exchange Domains"
  description   = "For each domain that is configured in Exchange, a corresponding Sender Policy Framework (SPF) record should be created."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_4_9.md")

  tags = merge(local.cis_v140_4_common_tags, {
    cis_item_id           = "4.9"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_4_10" {
  title         = "4.10 Ensure DMARC Records for all Exchange Online domains are published"
  description   = "Publish Domain-Based Message Authentication, Reporting and Conformance (DMARC) records for each Exchange Online Accepted Domain."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_4_10.md")

  tags = merge(local.cis_v140_4_common_tags, {
    cis_item_id           = "4.10"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_4_11" {
  title         = "4.11 Ensure notifications for internal users sending malware is Enabled"
  description   = "Setup the EOP malware filter to notify administrators if internal senders are blocked for sending malware."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_4_11.md")

  tags = merge(local.cis_v140_4_common_tags, {
    cis_item_id           = "4.11"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v140_4_12" {
  title         = "4.12 Ensure MailTips are enabled for end users"
  description   = "MailTips assist end users with identifying strange patterns to emails they send."
  sql           = query.azuread_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_4_12.md")

  tags = merge(local.cis_v140_4_common_tags, {
    cis_item_id           = "4.12"
    cis_level             = "2"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}
