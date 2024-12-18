locals {
  cis_v400_5_common_tags = merge(local.cis_v400_common_tags, {
    cis_section_id = "5"
  })
}

locals {
  cis_v400_5_1_common_tags = merge(local.cis_v400_5_common_tags, {
    cis_section_id = "5.1"
  })
}

locals {
  cis_v400_5_1_1_common_tags = merge(local.cis_v400_5_1_common_tags, {
    cis_section_id = "5.1.1"
  })
}

locals {
  cis_v400_5_1_2_common_tags = merge(local.cis_v400_5_1_common_tags, {
    cis_section_id = "5.1.2"
  })
}

locals {
  cis_v400_5_1_5_common_tags = merge(local.cis_v400_5_1_common_tags, {
    cis_section_id = "5.1.5"
  })
}

locals {
  cis_v400_5_2_common_tags = merge(local.cis_v400_5_common_tags, {
    cis_section_id = "5.2"
  })
}

locals {
  cis_v400_5_2_2_common_tags = merge(local.cis_v400_5_2_common_tags, {
    cis_section_id = "5.2.2"
  })
}

locals {
  cis_v400_5_2_4_common_tags = merge(local.cis_v400_5_2_common_tags, {
    cis_section_id = "5.2.4"
  })
}

benchmark "cis_v400_5" {
  title         = "5 Microsoft Entra admin center"
  documentation = file("./cis_v400/docs/cis_v400_5.md")
  children = [
    benchmark.cis_v400_5_1,
    benchmark.cis_v400_5_2
  ]

  tags = merge(local.cis_v400_5_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v400_5_1" {
  title = "5.1 Identity"
  children = [
    benchmark.cis_v400_5_1_1,
    benchmark.cis_v400_5_1_2,
    benchmark.cis_v400_5_1_5
  ]

  tags = merge(local.cis_v400_5_1_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v400_5_1_1" {
  title = "5.1.1 Overview"
  children = [
    control.cis_v400_5_1_1_1
  ]

  tags = merge(local.cis_v400_5_1_1_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v400_5_1_1_1" {
  title         = "5.1.1.1 Ensure Security Defaults is disabled"
  description   = "Security defaults in Azure Active Directory (Azure AD) make it easier to be secure and help protect the organization. Security defaults contain preconfigured security settings for common attacks. By default, Microsoft enables security defaults. The goal is to ensure that all organizations have a basic level of security enabled. The security default setting is manipulated in the Azure Portal."
  query         = query.azuread_security_default_disabled
  documentation = file("./cis_v400/docs/cis_v400_5_1_1_1.md")

  tags = merge(local.cis_v400_5_1_1_common_tags, {
    cis_item_id           = "5.1.1.1"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v400_5_1_2" {
  title = "5.1.2 Users"
  children = [
    control.cis_v400_5_1_2_2
  ]

  tags = merge(local.cis_v400_5_1_2_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v400_5_1_2_2" {
  title         = "5.1.2.2 Ensure third party integrated applications are not allowed"
  description   = "App registrations allows users to register custom-developed applications for use within the directory."
  query         = query.azuread_third_party_application_not_allowed
  documentation = file("./cis_v400/docs/cis_v400_5_1_2_2.md")

  tags = merge(local.cis_v400_5_1_2_common_tags, {
    cis_item_id           = "5.1.2.2"
    cis_level             = "2"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v400_5_1_5" {
  title = "5.1.5 Applications"
  children = [
    control.cis_v400_5_1_5_2
  ]

  tags = merge(local.cis_v400_5_1_5_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v400_5_1_5_2" {
  title         = "5.1.5.2 Ensure user consent to apps accessing company data on their behalf is not allowed"
  description   = "Control when end users and group owners are allowed to grant consent to applications, and when they will be required to request administrator review and approval. Allowing users to grant apps access to data helps them acquire useful applications and be productive but can represent a risk in some situations if it's not monitored and controlled carefully."
  query         = query.azuread_authorization_policy_accessing_company_data_not_allowed
  documentation = file("./cis_v400/docs/cis_v400_5_1_5_2.md")

  tags = merge(local.cis_v400_5_1_5_common_tags, {
    cis_item_id           = "5.1.5.2"
    cis_level             = "2"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v400_5_2" {
  title = "5.2 Protection"
  children = [
    benchmark.cis_v400_5_2_2,
    benchmark.cis_v400_5_2_4
  ]

  tags = merge(local.cis_v400_5_2_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v400_5_2_2" {
  title = "5.2.2 Conditional Access"
  children = [
    control.cis_v400_5_2_2_1,
    control.cis_v400_5_2_2_2,
    control.cis_v400_5_2_2_3,
    control.cis_v400_5_2_2_4,
    control.cis_v400_5_2_2_6,
    control.cis_v400_5_2_2_7,
    control.cis_v400_5_2_2_8
  ]

  tags = merge(local.cis_v400_5_2_2_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v400_5_2_2_1" {
  title         = "5.2.2.1 Ensure multifactor authentication is enabled for all users in administrative roles"
  description   = "Multi-factor authentication is a process that requires an additional form of identification during the sign-in process, such as a code from a mobile device or a fingerprint scan, to enhance security. Ensure users in administrator roles have MFA capabilities enabled."
  query         = query.azuread_admin_user_mfa_enabled
  documentation = file("./cis_v400/docs/cis_v400_5_2_2_1.md")

  tags = merge(local.cis_v400_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.1"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v400_5_2_2_2" {
  title         = "5.2.2.2 Ensure multifactor authentication is enabled for all users"
  description   = "Enable multifactor authentication for all users in the Microsoft 365 tenant. Users will be prompted to authenticate with a second factor upon logging in to Microsoft 365 services. The second factor is most commonly a text message to a registered mobile phone number where they type in an authorization code, or with a mobile application like Microsoft Authenticator."
  query         = query.azuread_all_user_mfa_enabled
  documentation = file("./cis_v400/docs/cis_v400_5_2_2_2.md")

  tags = merge(local.cis_v400_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.2"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v400_5_2_2_3" {
  title         = "5.2.2.3 Enable Conditional Access policies to block legacy authentication"
  description   = "Entra ID supports the most widely used authentication and authorization protocols including legacy authentication. This authentication pattern includes basic authentication, a widely used industry-standard method for collecting username and password information."
  query         = query.azuread_legacy_authentication_disabled
  documentation = file("./cis_v400/docs/cis_v400_5_2_2_3.md")

  tags = merge(local.cis_v400_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.3"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v400_5_2_2_4" {
  title         = "5.2.2.4 Ensure Sign-in frequency is enabled and browser sessions are not persistent for Administrative users"
  description   = "In complex deployments, organizations might have a need to restrict authentication sessions."
  query         = query.azuread_signin_frequency_policy
  documentation = file("./cis_v400/docs/cis_v400_5_2_2_4.md")

  tags = merge(local.cis_v400_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.4"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v400_5_2_2_6" {
  title         = "5.2.2.6 Enable Identity Protection user risk policies"
  description   = "Microsoft Entra ID Protection user risk policies detect the probability that a user account has been compromised"
  query         = query.azuread_user_risk_policy
  documentation = file("./cis_v400/docs/cis_v400_5_2_2_6.md")

  tags = merge(local.cis_v400_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.6"
    cis_level             = "2"
    cis_type              = "manual"
    microsoft_365_license = "E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v400_5_2_2_7" {
  title         = "5.2.2.7 Enable Identity Protection sign-in risk policies"
  description   = "Microsoft Entra ID Protection sign-in risk detects risks in real-time and offline. A risky sign-in is an indicator for a sign-in attempt that might not have been performed by the legitimate owner of a user account."
  query         = query.azuread_signin_risk_policy
  documentation = file("./cis_v400/docs/cis_v400_5_2_2_7.md")

  tags = merge(local.cis_v400_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.7"
    cis_level             = "2"
    cis_type              = "manual"
    microsoft_365_license = "E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v400_5_2_2_8" {
  title         = "5.2.2.8 Ensure admin center access is limited to administrative roles"
  description   = "When a Conditional Access policy targets the Microsoft Admin Portals cloud app. Microsoft Admin Portals should be restricted to specific pre-determined administrative roles."
  query         = query.azuread_microsoft_azure_management_limited_to_administrative_roles
  documentation = file("./cis_v400/docs/cis_v400_5_2_2_8.md")

  tags = merge(local.cis_v400_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.8"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v400_5_2_4" {
  title = "5.2.4 Password reset"
  children = [
    control.cis_v400_5_2_4_1
  ]

  tags = merge(local.cis_v400_5_2_4_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v400_5_2_4_1" {
  title         = "5.2.4.1 Ensure 'Self service password reset enabled' is set to 'All'"
  description   = "Enabling self-service password reset allows users to reset their own passwords in Azure AD. When users sign in to Microsoft 365, they will be prompted to enter additional contact information that will help them reset their password in the future. If combined registration is enabled additional information, outside of multi-factor, will not be needed."
  query         = query.azuread_user_sspr_enabled
  documentation = file("./cis_v400/docs/cis_v400_5_2_4_1.md")

  tags = merge(local.cis_v400_5_2_4_common_tags, {
    cis_item_id           = "5.2.4.1"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}
