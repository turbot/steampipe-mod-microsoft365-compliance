locals {
  cis_v200_1_common_tags = merge(local.cis_v200_common_tags, {
    cis_section_id = "1"
  })
}

locals {
  cis_v200_1_1_common_tags = merge(local.cis_v200_1_common_tags, {
    cis_section_id = "1.1"
  })
}

benchmark "cis_v200_1" {
  title         = "1 Account and Authentication"
  documentation = file("./cis_v200/docs/cis_v200_1.md")
  children = [
    benchmark.cis_v200_1_1,
    control.cis_v200_1_4
  ]

  tags = merge(local.cis_v200_1_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v200_1_1" {
  title         = "1.1 Azure Active Directory"
  documentation = file("./cis_v200/docs/cis_v200_1_1.md")
  children = [
    control.cis_v200_1_1_1,
    control.cis_v200_1_1_2,
    control.cis_v200_1_1_3,
    control.cis_v200_1_1_4,
    control.cis_v200_1_1_7,
    control.cis_v200_1_1_8,
    control.cis_v200_1_1_11,
    control.cis_v200_1_1_13,
    control.cis_v200_1_1_14,
    control.cis_v200_1_1_16,
    control.cis_v200_1_1_21
  ]

  tags = merge(local.cis_v200_1_1_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v200_1_1_1" {
  title         = "1.1.1 Ensure Security Defaults is disabled on Azure Active Directory"
  description   = "Security defaults in Azure Active Directory (Azure AD) make it easier to be secure and help protect the organization. Security defaults contain preconfigured security settings for common attacks. By default, Microsoft enables security defaults. The goal is to ensure that all organizations have a basic level of security-enabled. The security default setting is manipulated in the Azure Portal. The use of security defaults however, will prohibit custom settings which are being set with more advanced settings from this benchmark."
  query         = query.azuread_security_default_disabled
  documentation = file("./cis_v200/docs/cis_v200_1_1_1.md")

  tags = merge(local.cis_v200_1_1_common_tags, {
    cis_item_id           = "1.1.1"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v200_1_1_2" {
  title         = "1.1.2 Ensure multifactor authentication is enabled for all users in administrative roles"
  description   = "Multi-factor authentication is a process that requires an additional form of identification during the sign-in process, such as a code from a mobile device or a fingerprint scan, to enhance security. Ensure users in administrator roles have MFA capabilities enabled."
  query         = query.azuread_admin_user_mfa_enabled
  documentation = file("./cis_v200/docs/cis_v200_1_1_2.md")

  tags = merge(local.cis_v200_1_1_common_tags, {
    cis_item_id           = "1.1.2"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v200_1_1_3" {
  title         = "1.1.3 Ensure Sign-in frequency is enabled and browser sessions are not persistent for Administrative users"
  description   = "In complex deployments, organizations might have a need to restrict authentication sessions. Conditional Access policies allow for the targeting of specific user accounts. Some scenarios might include: -Resource access from an unmanaged or shared device. -Access to sensitive information from an external network. -High-privileged users -Business-critical applications. Ensure Sign-in frequency does not exceed 4 hours for E3 tenants, or 24 hours for E5 tenants using Privileged Identity Management. Ensure Persistent browser session is set to Never persist"
  query         = query.azuread_signin_frequency_policy
  documentation = file("./cis_v200/docs/cis_v200_1_1_3.md")

  tags = merge(local.cis_v200_1_1_common_tags, {
    cis_item_id           = "1.1.3"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v200_1_1_4" {
  title         = "1.1.4 Ensure multifactor authentication is enabled for all users"
  description   = "Enable multifactor authentication for all users in the Microsoft 365 tenant. Users will be prompted to authenticate with a second factor upon logging in to Microsoft 365 services. The second factor is most commonly a text message to a registered mobile phone number where they type in an authorization code, or with a mobile application like Microsoft Authenticator."
  query         = query.azuread_all_user_mfa_enabled
  documentation = file("./cis_v200/docs/cis_v200_1_1_4.md")

  tags = merge(local.cis_v200_1_1_common_tags, {
    cis_item_id           = "1.1.4"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v200_1_1_7" {
  title         = "1.1.7 Ensure that between two and four global admins are designated"
  description   = "More than one global administrator should be designated so a single admin can be monitored and to provide redundancy should a single admin leave an organization. Additionally, there should be no more than four global admins set for any tenant. Ideally global administrators will have no licenses assigned to them."
  query         = query.azuread_global_admin_range_restricted
  documentation = file("./cis_v200/docs/cis_v200_1_1_7.md")

  tags = merge(local.cis_v200_1_1_common_tags, {
    cis_item_id           = "1.1.7"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v200_1_1_8" {
  title         = "1.1.8 Ensure 'Self service password reset enabled' is set to 'All'"
  description   = "Enabling self-service password reset allows users to reset their own passwords in Azure AD. When users sign in to Microsoft 365, they will be prompted to enter additional contact information that will help them reset their password in the future. If combined registration is enabled additional information, outside of multi-factor, will not be needed."
  query         = query.azuread_user_sspr_enabled
  documentation = file("./cis_v200/docs/cis_v200_1_1_8.md")

  tags = merge(local.cis_v200_1_1_common_tags, {
    cis_item_id           = "1.1.8"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v200_1_1_11" {
  title         = "1.1.11 Enable Conditional Access policies to block legacy authentication"
  description   = "Azure AD supports the most widely used authentication and authorization protocols including legacy authentication. This authentication pattern includes basic authentication, a widely used industry-standard method for collecting user name and password information."
  query         = query.azuread_legacy_authentication_disabled
  documentation = file("./cis_v200/docs/cis_v200_1_1_11.md")

  tags = merge(local.cis_v200_1_1_common_tags, {
    cis_item_id           = "1.1.11"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v200_1_1_13" {
  title         = "1.1.13 Enable Azure AD Identity Protection sign-in risk policies"
  description   = "Azure Active Directory Identity Protection sign-in risk detects risks in real-time and offline. A risky sign-in is an indicator for a sign-in attempt that might not have been performed by the legitimate owner of a user account."
  query         = query.azuread_signin_risk_policy
  documentation = file("./cis_v200/docs/cis_v200_1_1_13.md")

  tags = merge(local.cis_v200_1_1_common_tags, {
    cis_item_id           = "1.1.13"
    cis_level             = "2"
    cis_type              = "manual"
    microsoft_365_license = "E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v200_1_1_14" {
  title         = "1.1.14 Enable Azure AD Identity Protection user risk policies"
  description   = "Azure Active Directory Identity Protection user risk policies detect the probability that a user account has been compromised."
  query         = query.azuread_user_risk_policy
  documentation = file("./cis_v200/docs/cis_v200_1_1_14.md")

  tags = merge(local.cis_v200_1_1_common_tags, {
    cis_item_id           = "1.1.14"
    cis_level             = "2"
    cis_type              = "manual"
    microsoft_365_license = "E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v200_1_1_16" {
  title         = "1.1.16 Ensure that only organizationally managed/approved public groups exist"
  description   = "Microsoft 365 Groups is the foundational membership service that drives all teamwork across Microsoft 365. With Microsoft 365 Groups, you can give a group of people access to a collection of shared resources. While there are several different types of group types this recommendation is concerned with Microsoft 365 Groups. In the Administration panel, when a group is created, the default privacy value is 'Public'."
  query         = query.azuread_group_not_public
  documentation = file("./cis_v200/docs/cis_v200_1_1_16.md")

  tags = merge(local.cis_v200_1_1_common_tags, {
    cis_item_id           = "1.1.16"
    cis_level             = "2"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v200_1_1_21" {
  title         = "1.1.21 Ensure 'Microsoft Azure Management' is limited to administrative roles"
  description   = "The Microsoft Azure Management application governs various Azure services and can be secured through the implementation of a Conditional Access policy. This policy can restrict specific user accounts from accessing the related portals and applications."
  query         = query.azuread_microsoft_azure_management_limited_to_administrative_roles
  documentation = file("./cis_v200/docs/cis_v200_1_1_21.md")

  tags = merge(local.cis_v200_1_1_common_tags, {
    cis_item_id           = "1.1.21"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v200_1_4" {
  title         = "1.4 Ensure the 'Password expiration policy' is set to 'Set passwords to never expire"
  description   = "Microsoft cloud-only accounts have a pre-defined password policy that cannot be changed. The only items that can change are the number of days until a password expires and whether or not passwords expire at all."
  query         = query.azuread_user_password_not_set_to_expire
  documentation = file("./cis_v200/docs/cis_v200_1_4.md")

  tags = merge(local.cis_v200_1_common_tags, {
    cis_item_id           = "1.4"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}
