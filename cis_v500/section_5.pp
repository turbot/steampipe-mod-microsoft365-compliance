locals {
  cis_v500_5_common_tags = merge(local.cis_v500_common_tags, {
    cis_section_id = "5"
  })
}

locals {
  cis_v500_5_1_common_tags = merge(local.cis_v500_5_common_tags, {
    cis_section_id = "5.1"
  })
}

locals {
  cis_v500_5_1_2_common_tags = merge(local.cis_v500_5_1_common_tags, {
    cis_section_id = "5.1.2"
  })
}

locals {
  cis_v500_5_1_3_common_tags = merge(local.cis_v500_5_1_common_tags, {
    cis_section_id = "5.1.3"
  })
}

locals {
  cis_v500_5_1_5_common_tags = merge(local.cis_v500_5_1_common_tags, {
    cis_section_id = "5.1.5"
  })
}

locals {
  cis_v500_5_2_common_tags = merge(local.cis_v500_5_common_tags, {
    cis_section_id = "5.2"
  })
}

locals {
  cis_v500_5_2_2_common_tags = merge(local.cis_v500_5_2_common_tags, {
    cis_section_id = "5.2.2"
  })
}

locals {
  cis_v500_5_2_3_common_tags = merge(local.cis_v500_5_2_common_tags, {
    cis_section_id = "5.2.3"
  })
}

locals {
  cis_v500_5_2_4_common_tags = merge(local.cis_v500_5_2_common_tags, {
    cis_section_id = "5.2.4"
  })
}

locals {
  cis_v500_5_3_common_tags = merge(local.cis_v500_5_common_tags, {
    cis_section_id = "5.3"
  })
}


benchmark "cis_v500_5" {
  title         = "5 Microsoft Entra admin center"
  documentation = file("./cis_v500/docs/cis_v500_5.md")
  children = [
    benchmark.cis_v500_5_1,
    benchmark.cis_v500_5_2,
    benchmark.cis_v500_5_3
  ]

  tags = merge(local.cis_v500_5_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v500_5_1" {
  title = "5.1 Identity"
  children = [
    benchmark.cis_v500_5_1_2,
    benchmark.cis_v500_5_1_3,
    benchmark.cis_v500_5_1_5
  ]

  tags = merge(local.cis_v500_5_1_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v500_5_1_2" {
  title = "5.1.2 Users"
  children = [
    control.cis_v500_5_1_2_2
  ]

  tags = merge(local.cis_v500_5_1_2_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v500_5_1_2_2" {
  title         = "5.1.2.2 Ensure third party integrated applications are not allowed"
  description   = "App registration allows users to register custom-developed applications for use within the directory."
  query         = query.azuread_third_party_application_not_allowed
  documentation = file("./cis_v500/docs/cis_v500_5_1_2_2.md")

  tags = merge(local.cis_v500_5_1_2_common_tags, {
    cis_item_id           = "5.1.2.2"
    cis_level             = "2"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v500_5_1_3" {
  title = "5.1.3 Groups"
  children = [
    control.cis_v500_5_1_3_1
  ]

  tags = merge(local.cis_v500_5_1_3_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v500_5_1_3_1" {
  title         = "5.1.3.1 Ensure a dynamic group for guest users is created"
  description   = "A dynamic group is a dynamic configuration of security group membership for Microsoft Entra ID. Administrators can set rules to populate groups that are created in Entra ID based on user attributes (such as userType, department, or country/region). Members can be automatically added to or removed from a security group based on their attributes. The recommended state is to create a dynamic group that includes guest accounts."
  query         = query.azuread_dynamic_group_for_guest_user
  documentation = file("./cis_v500/docs/cis_v500_5_1_3_1.md")

  tags = merge(local.cis_v500_5_1_3_common_tags, {
    cis_item_id           = "5.1.3.1"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v500_5_1_5" {
  title = "5.1.5 Applications"
  children = [
    control.cis_v500_5_1_5_1,
    control.cis_v500_5_1_5_2
  ]

  tags = merge(local.cis_v500_5_1_5_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v500_5_1_5_1" {
  title         = "5.1.5.1 Ensure user consent to apps accessing company data on their behalf is not allowed"
  description   = "Control when end users and group owners are allowed to grant consent to applications, and when they will be required to request administrator review and approval. Allowing users to grant apps access to data helps them acquire useful applications and be productive but can represent a risk in some situations if it's not monitored and controlled carefully."
  query         = query.azuread_authorization_policy_accessing_company_data_not_allowed
  documentation = file("./cis_v500/docs/cis_v500_5_1_5_1.md")

  tags = merge(local.cis_v500_5_1_5_common_tags, {
    cis_item_id           = "5.1.5.1"
    cis_level             = "2"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v500_5_1_5_2" {
  title         = "5.1.5.2 Ensure the admin consent workflow is enabled"
  description   = "The admin consent workflow gives admins a secure way to grant access to applications that require admin approval. When a user tries to access an application but is unable to provide consent, they can send a request for admin approval. The request is sent via email to admins who have been designated as reviewers. A reviewer takes action on the request, and the user is notified of the action."
  query         = query.azuread_admin_consent_workflow_enabled
  documentation = file("./cis_v500/docs/cis_v500_5_1_5_2.md")

  tags = merge(local.cis_v500_5_1_5_common_tags, {
    cis_item_id           = "5.1.5.2"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v500_5_2" {
  title = "5.2 Protection"
  children = [
    benchmark.cis_v500_5_2_2,
    benchmark.cis_v500_5_2_3,
    benchmark.cis_v500_5_2_4
  ]

  tags = merge(local.cis_v500_5_2_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v500_5_2_2" {
  title = "5.2.2 Conditional Access"
  children = [
    control.cis_v500_5_2_2_1,
    control.cis_v500_5_2_2_2,
    control.cis_v500_5_2_2_3,
    control.cis_v500_5_2_2_4,
    control.cis_v500_5_2_2_6,
    control.cis_v500_5_2_2_7,
    control.cis_v500_5_2_2_8,
    control.cis_v500_5_2_2_9,
    control.cis_v500_5_2_2_10,
    control.cis_v500_5_2_2_11,
    control.cis_v500_5_2_2_12
  ]

  tags = merge(local.cis_v500_5_2_2_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v500_5_2_2_1" {
  title         = "5.2.2.1 Ensure multifactor authentication is enabled for all users in administrative roles"
  description   = "Multifactor authentication is a process that requires an additional form of identification during the sign-in process, such as a code from a mobile device or a fingerprint scan, to enhance security."
  query         = query.azuread_admin_user_mfa_enabled
  documentation = file("./cis_v500/docs/cis_v500_5_2_2_1.md")

  tags = merge(local.cis_v500_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.1"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v500_5_2_2_2" {
  title         = "5.2.2.2 Ensure multifactor authentication is enabled for all users"
  description   = "Enable multifactor authentication for all users in the Microsoft 365 tenant. Users will be prompted to authenticate with a second factor upon logging in to Microsoft 365 services. The second factor is most commonly a text message to a registered mobile phone number where they type in an authorization code, or with a mobile application like Microsoft Authenticator."
  query         = query.azuread_all_user_mfa_enabled
  documentation = file("./cis_v500/docs/cis_v500_5_2_2_2.md")

  tags = merge(local.cis_v500_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.2"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v500_5_2_2_3" {
  title         = "5.2.2.3 Enable Conditional Access policies to block legacy authentication"
  description   = "Entra ID supports the most widely used authentication and authorization protocols including legacy authentication. This authentication pattern includes basic authentication, a widely used industry-standard method for collecting username and password information."
  query         = query.azuread_legacy_authentication_disabled
  documentation = file("./cis_v500/docs/cis_v500_5_2_2_3.md")

  tags = merge(local.cis_v500_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.3"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v500_5_2_2_4" {
  title         = "5.2.2.4 Ensure Sign-in frequency is enabled and browser sessions are not persistent for Administrative users"
  description   = "In complex deployments, organizations might have a need to restrict authentication sessions."
  query         = query.azuread_signin_frequency_policy
  documentation = file("./cis_v500/docs/cis_v500_5_2_2_4.md")

  tags = merge(local.cis_v500_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.4"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v500_5_2_2_6" {
  title         = "5.2.2.6 Enable Identity Protection user risk policies"
  description   = "Microsoft Entra ID Protection user risk policies detect the probability that a user account has been compromised."
  query         = query.azuread_user_risk_policy
  documentation = file("./cis_v500/docs/cis_v500_5_2_2_6.md")

  tags = merge(local.cis_v500_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.6"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v500_5_2_2_7" {
  title         = "5.2.2.7 Enable Identity Protection sign-in risk policies"
  description   = "Microsoft Entra ID Protection sign-in risk detects risks in real-time and offline. A risky sign-in is an indicator for a sign-in attempt that might not have been performed by the legitimate owner of a user account."
  query         = query.azuread_signin_risk_policy
  documentation = file("./cis_v500/docs/cis_v500_5_2_2_7.md")

  tags = merge(local.cis_v500_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.7"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v500_5_2_2_8" {
  title         = "5.2.2.8 Ensure 'sign-in risk' is blocked for medium and high risk"
  description   = "Microsoft Entra ID Protection sign-in risk detects risks in real-time and offline. A risky sign-in is an indicator for a sign-in attempt that might not have been performed by the legitimate owner of a user account."
  query         = query.azuread_conditional_access_block_signin_risk_medium_high
  documentation = file("./cis_v500/docs/cis_v500_5_2_2_8.md")

  tags = merge(local.cis_v500_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.8"
    cis_level             = "2"
    cis_type              = "automated"
    microsoft_365_license = "E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v500_5_2_2_9" {
  title         = "5.2.2.9 Ensure a managed device is required for authentication"
  description   = "Conditional Access (CA) can be configured to enforce access based on the device's compliance status or whether it is Entra hybrid joined. Collectively this allows CA to classify devices as managed or unmanaged, providing more granular control over authentication policies."
  query         = query.azuread_conditional_access_require_managed_device_for_authentication
  documentation = file("./cis_v500/docs/cis_v500_5_2_2_9.md")

  tags = merge(local.cis_v500_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.9"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v500_5_2_2_10" {
  title         = "5.2.2.10 Ensure a managed device is required to register security information"
  description   = "Conditional Access (CA) can be configured to enforce access based on the device's compliance status or whether it is Entra hybrid joined. Collectively this allows CA to classify devices as managed or not, providing more granular control over whether or not a user can register MFA on a device."
  query         = query.azuread_conditional_access_require_managed_device_register_security_info
  documentation = file("./cis_v500/docs/cis_v500_5_2_2_10.md")

  tags = merge(local.cis_v500_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.10"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v500_5_2_2_11" {
  title         = "5.2.2.11 Ensure sign-in frequency for Intune Enrollment is set to 'Every time'"
  description   = "Sign-in frequency defines the time period before a user is asked to sign in again when attempting to access a resource. The Microsoft Entra ID default configuration for user sign-in frequency is a rolling window of 90 days."
  query         = query.azuread_conditional_access_signin_frequency_intune_every_time
  documentation = file("./cis_v500/docs/cis_v500_5_2_2_11.md")

  tags = merge(local.cis_v500_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.11"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v500_5_2_2_12" {
  title         = "5.2.2.12 Ensure the device code sign-in flow is blocked"
  description   = "The Microsoft identity platform supports the device authorization grant, which allows users to sign in to input-constrained devices such as a smart TV, IoT device, or a printer. To enable this flow, the device has the user visit a webpage in a browser on another device to sign in. Once the user signs in, the device is able to get access tokens and refresh tokens as needed."
  query         = query.azuread_conditional_access_block_device_code_flow
  documentation = file("./cis_v500/docs/cis_v500_5_2_2_12.md")

  tags = merge(local.cis_v500_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.12"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v500_5_2_3" {
  title = "5.2.3 Authentication Methods"
  children = [
    control.cis_v500_5_2_3_1,
    control.cis_v500_5_2_3_4,
    control.cis_v500_5_2_3_5
  ]

  tags = merge(local.cis_v500_5_2_3_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v500_5_2_3_1" {
  title         = "5.2.3.1 Ensure Microsoft Authenticator is configured to protect against MFA fatigue"
  description   = "Microsoft provides supporting settings to enhance the configuration of the Microsoft Authenticator application. These settings provide users with additional information and context when they receive MFA passwordless and push requests, including the geographic location of the request, the requesting application, and a requirement for number matching."
  query         = query.azuread_authentication_method_microsoft_authenticator_mfa_fatigue_protection
  documentation = file("./cis_v500/docs/cis_v500_5_2_3_1.md")

  tags = merge(local.cis_v500_5_2_3_common_tags, {
    cis_item_id           = "5.2.3.1"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v500_5_2_3_4" {
  title         = "5.2.3.4 Ensure all member users are 'MFA capable'"
  description   = "Microsoft defines Multifactor authentication capable as being registered and enabled for a strong authentication method. The method must also be allowed by the authentication methods policy.Ensure all member users are MFA capable. "
  query         = query.microsoft_user_mfa_capable
  documentation = file("./cis_v500/docs/cis_v500_5_2_3_4.md")

  tags = merge(local.cis_v500_5_2_3_common_tags, {
    cis_item_id           = "5.2.3.4"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v500_5_2_3_5" {
  title         = "5.2.3.5 Ensure weak authentication methods are disabled"
  description   = "Authentication methods support a wide variety of scenarios for signing in to Microsoft 365 resources. Some of these methods are inherently more secure than others but require more investment in time to get users enrolled and operational. SMS and Voice Call rely on telephony carrier communication methods to deliver the authenticating factor."
  query         = query.azuread_authentication_method_restrict_insecure_methods
  documentation = file("./cis_v500/docs/cis_v500_5_2_3_5.md")

  tags = merge(local.cis_v500_5_2_3_common_tags, {
    cis_item_id           = "5.2.3.5"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v500_5_2_4" {
  title = "5.2.4 Password reset"
  children = [
    control.cis_v500_5_2_4_1
  ]

  tags = merge(local.cis_v500_5_2_4_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v500_5_2_4_1" {
  title         = "5.2.4.1 Ensure 'Self service password reset enabled' is set to 'All'"
  description   = "Enabling self-service password reset allows users to reset their own passwords in Azure AD. When users sign in to Microsoft 365, they will be prompted to enter additional contact information that will help them reset their password in the future. If combined registration is enabled additional information, outside of multi-factor, will not be needed."
  query         = query.azuread_user_sspr_enabled
  documentation = file("./cis_v500/docs/cis_v500_5_2_4_1.md")

  tags = merge(local.cis_v500_5_2_4_common_tags, {
    cis_item_id           = "5.2.4.1"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v500_5_3" {
  title = "5.3 Identity Governance"
  children = [
    control.cis_v500_5_3_2,
    control.cis_v500_5_3_3
  ]

  tags = merge(local.cis_v500_5_3_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v500_5_3_2" {
  title         = "5.3.2 Ensure 'Access reviews' for Guest Users are configured"
  description   = "Access reviews enable administrators to establish an efficient automated process for reviewing group memberships, access to enterprise applications, and role assignments. These reviews can be scheduled to recur regularly, with flexible options for delegating the task of reviewing membership to different members of the organization."
  query         = query.azuread_guest_user_access_reviews_configured
  documentation = file("./cis_v500/docs/cis_v500_5_3_2.md")

  tags = merge(local.cis_v500_5_3_common_tags, {
    cis_item_id           = "5.3.2"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v500_5_3_3" {
  title         = "5.3.3 Ensure 'Access reviews' for privileged roles are configured"
  description   = "Access reviews enable administrators to establish an efficient automated process for reviewing group memberships, access to enterprise applications, and role assignments. These reviews can be scheduled to recur regularly, with flexible options for delegating the task of reviewing membership to different members of the organization."
  query         = query.azuread_privileged_roles_access_reviews_configured
  documentation = file("./cis_v500/docs/cis_v500_5_3_3.md")

  tags = merge(local.cis_v500_5_3_common_tags, {
    cis_item_id           = "5.3.3"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E5"
    service               = "Azure/ActiveDirectory"
  })
}