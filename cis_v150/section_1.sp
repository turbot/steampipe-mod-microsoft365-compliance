locals {
  cis_v150_1_common_tags = merge(local.cis_v150_common_tags, {
    cis_section_id = "1"
  })
}

locals {
  cis_v150_1_1_common_tags = merge(local.cis_v150_1_common_tags, {
    cis_section_id = "1.1"
  })
}

benchmark "cis_v150_1" {
  title         = "1 Account and Authentication"
  documentation = file("./cis_v150/docs/cis_v150_1.md")
  children = [
    benchmark.cis_v150_1_1,
    control.cis_v150_1_4
  ]

  tags = merge(local.cis_v150_1_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v150_1_1" {
  title         = "1.1 Azure Active Directory"
  documentation = file("./cis_v150/docs/cis_v150_1_1.md")
  children = [
    control.cis_v150_1_1_1,
    control.cis_v150_1_1_2,
    control.cis_v150_1_1_3,
    control.cis_v150_1_1_4,
    control.cis_v150_1_1_5,
    control.cis_v150_1_1_6,
    control.cis_v150_1_1_8,
    control.cis_v150_1_1_9,
    control.cis_v150_1_1_11,
    control.cis_v150_1_1_12,
    control.cis_v150_1_1_15
  ]

  tags = merge(local.cis_v150_1_1_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v150_1_1_1" {
  title         = "1.1.1 Ensure multifactor authentication is enabled for all users in administrative roles"
  description   = "Enable multifactor authentication for all users who are members of administrative roles in the Microsoft 365 tenant."
  query         = query.azuread_admin_user_mfa_enabled
  documentation = file("./cis_v150/docs/cis_v150_1_1_1.md")

  tags = merge(local.cis_v150_1_1_common_tags, {
    cis_item_id           = "1.1.1"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v150_1_1_2" {
  title         = "1.1.2 Ensure multifactor authentication is enabled for all users in all roles"
  description   = "Enable multifactor authentication for all users in the Microsoft 365 tenant. Users will be prompted to authenticate with a second factor upon logging in to Microsoft 365 services. The second factor is most commonly a text message to a registered mobile phone number where they type in an authorization code, or with a mobile application like Microsoft Authenticator."
  query         = query.azuread_all_user_mfa_enabled
  documentation = file("./cis_v150/docs/cis_v150_1_1_2.md")

  tags = merge(local.cis_v150_1_1_common_tags, {
    cis_item_id           = "1.1.2"
    cis_level             = "2"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v150_1_1_3" {
  title         = "1.1.3 Ensure that between two and four global admins are designated"
  description   = "More than one global administrator should be designated so a single admin can be monitored and to provide redundancy should a single admin leave an organization. Additionally, there should be no more than four global admins set for any tenant. Ideally global administrators will have no licenses assigned to them."
  query         = query.azuread_global_admin_range_restricted
  documentation = file("./cis_v150/docs/cis_v150_1_1_3.md")

  tags = merge(local.cis_v150_1_1_common_tags, {
    cis_item_id           = "1.1.3"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v150_1_1_4" {
  title         = "1.1.4 Ensure self-service password reset is enabled"
  description   = "Enabling self-service password reset allows users to reset their own passwords in Azure AD. When your users sign in to Microsoft 365, they will be prompted to enter additional contact information that will help them reset their password in the future. If combined registration is enabled additional information, outside of multi-factor, will not be needed. As of August 2020 combined registration is enabled by default."
  query         = query.azuread_user_sspr_enabled
  documentation = file("./cis_v150/docs/cis_v150_1_1_4.md")

  tags = merge(local.cis_v150_1_1_common_tags, {
    cis_item_id           = "1.1.4"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v150_1_1_5" {
  title         = "1.1.5 Ensure that password protection is enabled for Active Directory"
  description   = "Enable Azure Active Directory Password Protection to Active Directory to protect against the use of common passwords."
  query         = query.azuread_password_protection_enabled
  documentation = file("./cis_v150/docs/cis_v150_1_1_5.md")

  tags = merge(local.cis_v150_1_1_common_tags, {
    cis_item_id           = "1.1.5"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v150_1_1_6" {
  title         = "1.1.6 Enable Conditional Access policies to block legacy authentication"
  description   = "Use Conditional Access to block legacy authentication protocols in Office 365."
  query         = query.azuread_legacy_authentication_disabled
  documentation = file("./cis_v150/docs/cis_v150_1_1_6.md")

  tags = merge(local.cis_v150_1_1_common_tags, {
    cis_item_id           = "1.1.6"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v150_1_1_8" {
  title         = "1.1.8 Enable Azure AD Identity Protection sign-in risk policies"
  description   = "Azure Active Directory Identity Protection sign-in risk detects risks in real-time and offline. A risky sign-in is an indicator for a sign-in attempt that might not have been performed by the legitimate owner of a user account."
  query         = query.azuread_signin_risk_policy
  documentation = file("./cis_v150/docs/cis_v150_1_1_8.md")

  tags = merge(local.cis_v150_1_1_common_tags, {
    cis_item_id           = "1.1.8"
    cis_level             = "2"
    cis_type              = "manual"
    microsoft_365_license = "E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v150_1_1_9" {
  title         = "1.1.9 Enable Azure AD Identity Protection user risk policies"
  description   = "Azure Active Directory Identity Protection user risk policies detect the probability that a user account has been compromised."
  query         = query.azuread_user_risk_policy
  documentation = file("./cis_v150/docs/cis_v150_1_1_9.md")

  tags = merge(local.cis_v150_1_1_common_tags, {
    cis_item_id           = "1.1.9"
    cis_level             = "2"
    cis_type              = "manual"
    microsoft_365_license = "E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v150_1_1_11" {
  title         = "1.1.11 Ensure Security Defaults is disabled on Azure Active Directory"
  description   = "Security defaults in Azure Active Directory (Azure AD) make it easier to be secure and help protect your organization. Security defaults contain preconfigured security settings for common attacks. Microsoft is making security defaults available to everyone. The goal is to ensure that all organizations have a basic level of security-enabled at no extra cost. You turn on security defaults in the Azure portal. The use of security defaults however will prohibit custom settings which are being set with more advanced settings from this benchmark."
  query         = query.azuread_security_default_disabled
  documentation = file("./cis_v150/docs/cis_v150_1_1_11.md")

  tags = merge(local.cis_v150_1_1_common_tags, {
    cis_item_id           = "1.1.11"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v150_1_1_12" {
  title         = "1.1.12 Ensure that only organizationally managed/approved public groups exist"
  description   = "Microsoft 365 Groups is the foundational membership service that drives all teamwork across Microsoft 365. With Microsoft 365 Groups, you can give a group of people access to a collection of shared resources. While there are several different types of group types this recommendation is concerned with Microsoft 365 Groups. In the Administration panel, when a group is created, the default privacy value is 'Public'."
  query         = query.azuread_group_not_public
  documentation = file("./cis_v150/docs/cis_v150_1_1_12.md")

  tags = merge(local.cis_v150_1_1_common_tags, {
    cis_item_id           = "1.1.12"
    cis_level             = "2"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v150_1_1_15" {
  title         = "1.1.15 Ensure Sign-in frequency is enabled and browser sessions are not persistent for Administrative users"
  description   = "Forcing a time out for MFA will help ensure that sessions are not kept alive for an indefinite period of time, ensuring that browser sessions are not persistent will help in prevention of drive-by attacks in web browsers, this also prevents creation and saving of session cookies leaving nothing for an attacker to take."
  query         = query.azuread_signin_frequency_policy
  documentation = file("./cis_v150/docs/cis_v150_1_1_15.md")

  tags = merge(local.cis_v150_1_1_common_tags, {
    cis_item_id           = "1.1.15"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v150_1_4" {
  title         = "1.4 Ensure that Office 365 Passwords Are Not Set to Expire"
  description   = "Microsoft cloud-only accounts have a pre-defined password policy that cannot be changed. The only items that can change are the number of days until a password expires and whether or not passwords expire at all."
  query         = query.azuread_user_password_not_set_to_expire
  documentation = file("./cis_v150/docs/cis_v150_1_4.md")

  tags = merge(local.cis_v150_1_common_tags, {
    cis_item_id           = "1.4"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}
