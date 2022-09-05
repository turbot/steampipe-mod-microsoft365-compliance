locals {
  cis_v140_1_common_tags = merge(local.cis_v140_common_tags, {
    cis_section_id = "1"
  })
}

locals {
  cis_v140_1_1_common_tags = merge(local.cis_v140_1_common_tags, {
    cis_section_id = "1.1"
  })
}

benchmark "cis_v140_1" {
  title         = "1 Account and Authentication"
  documentation = file("./cis_v140/docs/cis_v140_1.md")
  children = [
    benchmark.cis_v140_1_1,
    control.cis_v140_1_5
  ]

  tags = merge(local.cis_v140_1_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v140_1_1" {
  title         = "1.1 Azure Active Directory"
  documentation = file("./cis_v140/docs/cis_v140_1_1.md")
  children = [
    control.cis_v140_1_1_1,
    control.cis_v140_1_1_2,
    control.cis_v140_1_1_3,
    control.cis_v140_1_1_6,
    control.cis_v140_1_1_8,
    control.cis_v140_1_1_9,
    control.cis_v140_1_1_12
  ]

  tags = merge(local.cis_v140_1_1_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v140_1_1_1" {
  title         = "1.1.1 Ensure multifactor authentication is enabled for all users in administrative roles"
  description   = "Enable multifactor authentication for all users who are members of administrative roles in the Microsoft 365 tenant."
  sql           = query.ad_admin_user_mfa_enabled.sql
  documentation = file("./cis_v140/docs/cis_v140_1_1_1.md")

  tags = merge(local.cis_v140_1_1_common_tags, {
    cis_item_id = "1.1.1"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_1_1_2" {
  title         = "1.1.2 Ensure multifactor authentication is enabled for all users in all roles"
  description   = "Enable multifactor authentication for all users in the Microsoft 365 tenant. Users will be prompted to authenticate with a second factor upon logging in to Microsoft 365 services. The second factor is most commonly a text message to a registered mobile phone number where they type in an authorization code, or with a mobile application like Microsoft Authenticator."
  sql           = query.ad_all_user_mfa_enabled.sql
  documentation = file("./cis_v140/docs/cis_v140_1_1_2.md")

  tags = merge(local.cis_v140_1_1_common_tags, {
    cis_item_id = "1.1.2"
    cis_level   = "2"
    cis_type    = "manual"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_1_1_3" {
  title         = "1.1.3 Ensure that between two and four global admins are designated"
  description   = "More than one global administrator should be designated so a single admin can be monitored and to provide redundancy should a single admin leave an organization. Additionally, there should be no more than four global admins set for any tenant. Ideally global administrators will have no licenses assigned to them."
  sql           = query.ad_global_admin_range_restricted.sql
  documentation = file("./cis_v140/docs/cis_v140_1_1_3.md")

  tags = merge(local.cis_v140_1_1_common_tags, {
    cis_item_id = "1.1.3"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_1_1_4" {
  title         = "1.1.4 Ensure self-service password reset is enabled"
  description   = "Enabling self-service password reset allows users to reset their own passwords in Azure AD. When your users sign in to Microsoft 365, they will be prompted to enter additional contact information that will help them reset their password in the future. If combined registration is enabled additional information, outside of multi-factor, will not be needed. As of August 2020 combined registration is enabled by default."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_1_1_4.md")

  tags = merge(local.cis_v140_1_1_common_tags, {
    cis_item_id = "1.1.4"
    cis_level   = "1"
    cis_type    = "manual"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_1_1_5" {
  title         = "1.1.5 Ensure that password protection is enabled for Active Directory"
  description   = "Enable Azure Active Directory Password Protection to Active Directory to protect against the use of common passwords"
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_1_1_5.md")

  tags = merge(local.cis_v140_1_1_common_tags, {
    cis_item_id = "1.1.5"
    cis_level   = "1"
    cis_type    = "manual"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_1_1_6" {
  title         = "1.1.6 Enable Conditional Access policies to block legacy authentication"
  description   = "Use Conditional Access to block legacy authentication protocols in Office 365."
  sql           = query.ad_legacy_authentication_disabled.sql
  documentation = file("./cis_v140/docs/cis_v140_1_1_6.md")

  tags = merge(local.cis_v140_1_1_common_tags, {
    cis_item_id = "1.1.6"
    cis_level   = "1"
    cis_type    = "automated"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_1_1_8" {
  title         = "1.1.8 Enable Azure AD Identity Protection sign-in risk policies"
  description   = "Azure Active Directory Identity Protection sign-in risk detects risks in real-time and offline."
  sql           = query.ad_signin_risk_policy.sql
  documentation = file("./cis_v140/docs/cis_v140_1_1_8.md")

  tags = merge(local.cis_v140_1_1_common_tags, {
    cis_item_id = "1.1.8"
    cis_level   = "1"
    cis_type    = "manual"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_1_1_9" {
  title         = "1.1.9 Enable Azure AD Identity Protection user risk policies"
  description   = "Azure Active Directory Identity Protection user risk policies detect the probability that a user account has been compromised."
  sql           = query.ad_user_risk_policy.sql
  documentation = file("./cis_v140/docs/cis_v140_1_1_9.md")

  tags = merge(local.cis_v140_1_1_common_tags, {
    cis_item_id = "1.1.9"
    cis_level   = "1"
    cis_type    = "manual"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_1_1_12" {
  title         = "1.1.12 Ensure that only organizationally managed/approved public groups exist"
  description   = "Enable only organizationally managed and approved public groups exist."
  sql           = query.ad_group_not_public.sql
  documentation = file("./cis_v140/docs/cis_v140_1_1_12.md")

  tags = merge(local.cis_v140_1_1_common_tags, {
    cis_item_id = "1.1.12"
    cis_level   = "1"
    cis_type    = "manual"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_1_5" {
  title         = "1.5 Ensure that Office 365 Passwords Are Not Set to Expire"
  description   = "Review the password expiration policy, to ensure that user passwords in Office 365 are not set to expire."
  sql           = query.ad_users_password_not_set_to_expire.sql
  documentation = file("./cis_v140/docs/cis_v140_1_5.md")

  tags = merge(local.cis_v140_1_common_tags, {
    cis_item_id = "1.5"
    cis_level   = "1"
    cis_type    = "manual"
    service     = "Azure/ActiveDirectory"
  })
}

