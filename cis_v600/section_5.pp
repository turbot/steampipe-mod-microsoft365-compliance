locals {
  cis_v600_5_common_tags = merge(local.cis_v600_common_tags, {
    cis_section_id = "5"
  })
}

locals {
  cis_v600_5_1_common_tags = merge(local.cis_v600_5_common_tags, {
    cis_section_id = "5.1"
  })
}

locals {
  cis_v600_5_1_2_common_tags = merge(local.cis_v600_5_1_common_tags, {
    cis_section_id = "5.1.2"
  })
}

locals {
  cis_v600_5_1_3_common_tags = merge(local.cis_v600_5_1_common_tags, {
    cis_section_id = "5.1.3"
  })
}

locals {
  cis_v600_5_1_4_common_tags = merge(local.cis_v600_5_1_common_tags, {
    cis_section_id = "5.1.4"
  })
}

locals {
  cis_v600_5_1_5_common_tags = merge(local.cis_v600_5_1_common_tags, {
    cis_section_id = "5.1.5"
  })
}

locals {
  cis_v600_5_2_common_tags = merge(local.cis_v600_5_common_tags, {
    cis_section_id = "5.2"
  })
}

locals {
  cis_v600_5_2_2_common_tags = merge(local.cis_v600_5_2_common_tags, {
    cis_section_id = "5.2.2"
  })
}

locals {
  cis_v600_5_2_3_common_tags = merge(local.cis_v600_5_2_common_tags, {
    cis_section_id = "5.2.3"
  })
}

locals {
  cis_v600_5_2_4_common_tags = merge(local.cis_v600_5_2_common_tags, {
    cis_section_id = "5.2.4"
  })
}

locals {
  cis_v600_5_3_common_tags = merge(local.cis_v600_5_common_tags, {
    cis_section_id = "5.3"
  })
}

benchmark "cis_v600_5" {
  title         = "5 Microsoft Entra admin center"
  documentation = file("./cis_v600/docs/cis_v600_5.md")
  children = [
    benchmark.cis_v600_5_1,
    benchmark.cis_v600_5_2,
    benchmark.cis_v600_5_3
  ]

  tags = merge(local.cis_v600_5_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v600_5_1" {
  title = "5.1 Entra ID"
  children = [
    benchmark.cis_v600_5_1_2,
    benchmark.cis_v600_5_1_3,
    benchmark.cis_v600_5_1_4,
    benchmark.cis_v600_5_1_5
  ]

  tags = merge(local.cis_v600_5_1_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v600_5_1_2" {
  title = "5.1.2 Users"
  children = [
    control.cis_v600_5_1_2_2
  ]

  tags = merge(local.cis_v600_5_1_2_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_1_2_2" {
  title         = "5.1.2.2 Ensure third party integrated applications are not allowed"
  description   = "App registration allows users to register custom-developed applications for use within the directory."
  query         = query.azuread_third_party_application_not_allowed
  documentation = file("./cis_v600/docs/cis_v600_5_1_2_2.md")

  tags = merge(local.cis_v600_5_1_2_common_tags, {
    cis_item_id           = "5.1.2.2"
    cis_level             = "2"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v600_5_1_3" {
  title = "5.1.3 Groups"
  children = [
    control.cis_v600_5_1_3_1,
    control.cis_v600_5_1_3_2
  ]

  tags = merge(local.cis_v600_5_1_3_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_1_3_1" {
  title         = "5.1.3.1 Ensure a dynamic group for guest users is created"
  description   = "A dynamic group is a dynamic configuration of security group membership for Microsoft Entra ID. Administrators can set rules to populate groups that are created in Entra ID based on user attributes (such as userType, department, or country/region). Members can be automatically added to or removed from a security group based on their attributes. The recommended state is to create a dynamic group that includes guest accounts."
  query         = query.azuread_dynamic_group_for_guest_user
  documentation = file("./cis_v600/docs/cis_v600_5_1_3_1.md")

  tags = merge(local.cis_v600_5_1_3_common_tags, {
    cis_item_id           = "5.1.3.1"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_1_3_2" {
  title         = "5.1.3.2 Ensure users cannot create security groups"
  description   = "This setting allows users in the organization to create new security groups and add members to these groups in the Azure portal, API, or PowerShell. These new groups also show up in the Access Panel for all other users. If the policy setting on the group allows it, other users can create requests to join these groups. The recommended state is Users can create security groups in Azure portals, API or PowerShell set to No."
  query         = query.azuread_user_cannot_create_security_groups
  documentation = file("./cis_v600/docs/cis_v600_5_1_3_2.md")

  tags = merge(local.cis_v600_5_1_3_common_tags, {
    cis_item_id           = "5.1.3.2"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v600_5_1_4" {
  title = "5.1.4 Devices"
  children = [
    control.cis_v600_5_1_4_1,
    control.cis_v600_5_1_4_2,
    control.cis_v600_5_1_4_3,
    control.cis_v600_5_1_4_4,
    control.cis_v600_5_1_4_5,
    control.cis_v600_5_1_4_6
  ]

  tags = merge(local.cis_v600_5_1_4_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_1_4_1" {
  title         = "5.1.4.1 Ensure the ability to join devices to Entra is restricted"
  description   = "This setting enables you to select the users who can register their devices as Microsoft Entra joined devices. The recommended state is Selected or None. Note: This setting is applicable only to Microsoft Entra join on Windows 10 or newer. This setting doesn't apply to Microsoft Entra hybrid joined devices, Microsoft Entra joined VMs in Azure, or Microsoft Entra joined devices that use Windows Autopilot self-deployment mode because these methods work in a userless context."
  query         = query.azuread_device_join_restricted
  documentation = file("./cis_v600/docs/cis_v600_5_1_4_1.md")

  tags = merge(local.cis_v600_5_1_4_common_tags, {
    cis_item_id           = "5.1.4.1"
    cis_level             = "2"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_1_4_2" {
  title         = "5.1.4.2 Ensure the maximum number of devices per user is limited"
  description   = "This setting defines the maximum number of Microsoft Entra joined or registered devices that a user can have in Microsoft Entra ID. Once this limit is reached, no additional devices can be added until existing ones are removed. Values above 100 are automatically capped at 100. The recommended state is 20 or less."
  query         = query.azuread_max_devices_per_user_limited
  documentation = file("./cis_v600/docs/cis_v600_5_1_4_2.md")

  tags = merge(local.cis_v600_5_1_4_common_tags, {
    cis_item_id           = "5.1.4.2"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_1_4_3" {
  title         = "5.1.4.3 Ensure the GA role is not added as a local administrator during Entra join"
  description   = "This setting controls whether the Global Administrator role is automatically added to the local administrators group on a device during the Microsoft Entra join process. The recommended state is No."
  query         = query.azuread_ga_not_local_admin_on_join
  documentation = file("./cis_v600/docs/cis_v600_5_1_4_3.md")

  tags = merge(local.cis_v600_5_1_4_common_tags, {
    cis_item_id           = "5.1.4.3"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_1_4_4" {
  title         = "5.1.4.4 Ensure local administrator assignment is limited during Entra join"
  description   = "This setting determines if the Microsoft Entra user registering their device as Microsoft Entra join be added to the local administrators group. This setting applies only once during the actual registration of the device as Microsoft Entra join. The recommended state is Selected or None."
  query         = query.azuread_local_admin_assignment_limited
  documentation = file("./cis_v600/docs/cis_v600_5_1_4_4.md")

  tags = merge(local.cis_v600_5_1_4_common_tags, {
    cis_item_id           = "5.1.4.4"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_1_4_5" {
  title         = "5.1.4.5 Ensure Local Administrator Password Solution is enabled"
  description   = "Local Administrator Password Solution (LAPS) is the management of local account passwords on Windows devices. LAPS provides a solution to securely manage and retrieve the built-in local admin password. With cloud version of LAPS, customers can enable storing and rotation of local admin passwords for both Microsoft Entra and Microsoft Entra hybrid join devices. The recommended state is Yes."
  query         = query.azuread_laps_enabled
  documentation = file("./cis_v600/docs/cis_v600_5_1_4_5.md")

  tags = merge(local.cis_v600_5_1_4_common_tags, {
    cis_item_id           = "5.1.4.5"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_1_4_6" {
  title         = "5.1.4.6 Ensure users are restricted from recovering BitLocker keys"
  description   = "This setting determines if users can self-service recover their BitLocker key(s). 'Yes' restricts non-admin users from being able to see the BitLocker key(s) for their owned devices if there are any. 'No' allows all users to recover their BitLocker key(s). The recommended state is Yes."
  query         = query.azuread_user_bitlocker_recovery_restricted
  documentation = file("./cis_v600/docs/cis_v600_5_1_4_6.md")

  tags = merge(local.cis_v600_5_1_4_common_tags, {
    cis_item_id           = "5.1.4.6"
    cis_level             = "2"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v600_5_1_5" {
  title = "5.1.5 Applications"
  children = [
    control.cis_v600_5_1_5_1,
    control.cis_v600_5_1_5_2
  ]

  tags = merge(local.cis_v600_5_1_5_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_1_5_1" {
  title         = "5.1.5.1 Ensure user consent to apps accessing company data on their behalf is not allowed"
  description   = "Control when end users and group owners are allowed to grant consent to applications, and when they will be required to request administrator review and approval. Allowing users to grant apps access to data helps them acquire useful applications and be productive but can represent a risk in some situations if it's not monitored and controlled carefully."
  query         = query.azuread_authorization_policy_accessing_company_data_not_allowed
  documentation = file("./cis_v600/docs/cis_v600_5_1_5_1.md")

  tags = merge(local.cis_v600_5_1_5_common_tags, {
    cis_item_id           = "5.1.5.1"
    cis_level             = "2"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_1_5_2" {
  title         = "5.1.5.2 Ensure the admin consent workflow is enabled"
  description   = "The admin consent workflow gives admins a secure way to grant access to applications that require admin approval. When a user tries to access an application but is unable to provide consent, they can send a request for admin approval. The request is sent via email to admins who have been designated as reviewers. A reviewer takes action on the request, and the user is notified of the action."
  query         = query.azuread_admin_consent_workflow_enabled
  documentation = file("./cis_v600/docs/cis_v600_5_1_5_2.md")

  tags = merge(local.cis_v600_5_1_5_common_tags, {
    cis_item_id           = "5.1.5.2"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v600_5_2" {
  title = "5.2 ID Protection"
  children = [
    benchmark.cis_v600_5_2_2,
    benchmark.cis_v600_5_2_3,
    benchmark.cis_v600_5_2_4
  ]

  tags = merge(local.cis_v600_5_2_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v600_5_2_2" {
  title = "5.2.2 Risk-based Conditional Access"
  children = [
    control.cis_v600_5_2_2_1,
    control.cis_v600_5_2_2_2,
    control.cis_v600_5_2_2_3,
    control.cis_v600_5_2_2_4,
    control.cis_v600_5_2_2_6,
    control.cis_v600_5_2_2_7,
    control.cis_v600_5_2_2_8,
    control.cis_v600_5_2_2_9,
    control.cis_v600_5_2_2_10,
    control.cis_v600_5_2_2_11,
    control.cis_v600_5_2_2_12
  ]

  tags = merge(local.cis_v600_5_2_2_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_2_2_1" {
  title         = "5.2.2.1 Ensure multifactor authentication is enabled for all users in administrative roles"
  description   = "Multifactor authentication is a process that requires an additional form of identification during the sign-in process, such as a code from a mobile device or a fingerprint scan, to enhance security. Ensure users in administrator roles have MFA capabilities enabled."
  query         = query.azuread_admin_user_mfa_enabled
  documentation = file("./cis_v600/docs/cis_v600_5_2_2_1.md")

  tags = merge(local.cis_v600_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.1"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_2_2_2" {
  title         = "5.2.2.2 Ensure multifactor authentication is enabled for all users"
  description   = "Enable multifactor authentication for all users in the Microsoft 365 tenant. Users will be prompted to authenticate with a second factor upon logging in to Microsoft 365 services. The second factor is most commonly a text message to a registered mobile phone number where they type in an authorization code, or with a mobile application like Microsoft Authenticator."
  query         = query.azuread_all_user_mfa_enabled
  documentation = file("./cis_v600/docs/cis_v600_5_2_2_2.md")

  tags = merge(local.cis_v600_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.2"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_2_2_3" {
  title         = "5.2.2.3 Enable Conditional Access policies to block legacy authentication"
  description   = "Entra ID supports the most widely used authentication and authorization protocols including legacy authentication. This authentication pattern includes basic authentication, a widely used industry-standard method for collecting username and password information."
  query         = query.azuread_legacy_authentication_disabled
  documentation = file("./cis_v600/docs/cis_v600_5_2_2_3.md")

  tags = merge(local.cis_v600_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.3"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_2_2_4" {
  title         = "5.2.2.4 Ensure Sign-in frequency is enabled and browser sessions are not persistent for Administrative users"
  description   = "In complex deployments, organizations might have a need to restrict authentication sessions. Conditional Access policies allow for the targeting of specific user accounts. Some scenarios might include: • Resource access from an unmanaged or shared device • Access to sensitive information from an external network • High-privileged users • Business-critical applications Note: This CA policy can be added to the previous CA policy in this benchmark \"Ensure multifactor authentication is enabled for all users in administrative roles\"."
  query         = query.azuread_signin_frequency_policy
  documentation = file("./cis_v600/docs/cis_v600_5_2_2_4.md")

  tags = merge(local.cis_v600_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.4"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_2_2_6" {
  title         = "5.2.2.6 Enable Identity Protection user risk policies"
  description   = "Microsoft Entra ID Protection user risk policies detect the probability that a user account has been compromised."
  query         = query.azuread_user_risk_policy
  documentation = file("./cis_v600/docs/cis_v600_5_2_2_6.md")

  tags = merge(local.cis_v600_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.6"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_2_2_7" {
  title         = "5.2.2.7 Enable Identity Protection sign-in risk policies"
  description   = "Microsoft Entra ID Protection sign-in risk detects risks in real-time and offline. A risky sign-in is an indicator for a sign-in attempt that might not have been performed by the legitimate owner of a user account."
  query         = query.azuread_signin_risk_policy
  documentation = file("./cis_v600/docs/cis_v600_5_2_2_7.md")

  tags = merge(local.cis_v600_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.7"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_2_2_8" {
  title         = "5.2.2.8 Ensure 'sign-in risk' is blocked for medium and high risk"
  description   = "Microsoft Entra ID Protection sign-in risk detects risks in real-time and offline. A risky sign-in is an indicator for a sign-in attempt that might not have been performed by the legitimate owner of a user account. Note: While Identity Protection also provides two risk policies with limited conditions, Microsoft highly recommends setting up risk-based policies in Conditional Access as opposed to the \"legacy method\" for the following benefits: • Enhanced diagnostic data • Report-only mode integration • Graph API support • Use more Conditional Access attributes like sign-in frequency in the policy"
  query         = query.azuread_conditional_access_block_signin_risk_medium_high
  documentation = file("./cis_v600/docs/cis_v600_5_2_2_8.md")

  tags = merge(local.cis_v600_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.8"
    cis_level             = "2"
    cis_type              = "automated"
    microsoft_365_license = "E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_2_2_9" {
  title         = "5.2.2.9 Ensure a managed device is required for authentication"
  description   = "Conditional Access (CA) can be configured to enforce access based on the device's compliance status or whether it is Entra hybrid joined. Collectively this allows CA to classify devices as managed or unmanaged, providing more granular control over authentication policies. When using Require device to be marked as compliant, the device must pass checks configured in Compliance policies defined within Intune (Endpoint Manager). Before these checks can be applied, the device must first be enrolled in Intune MDM. By selecting Require Microsoft Entra hybrid joined device this means the device must first be synchronized from an on-premises Active Directory to qualify for authentication. When configured to the recommended state below only one condition needs to be met for the user to authenticate from the device. This functions as an \"OR\" operator. The recommended state is: • Require device to be marked as compliant • Require Microsoft Entra hybrid joined device • Require one of the selected controls"
  query         = query.azuread_conditional_access_require_managed_device_for_authentication
  documentation = file("./cis_v600/docs/cis_v600_5_2_2_9.md")

  tags = merge(local.cis_v600_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.9"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_2_2_10" {
  title         = "5.2.2.10 Ensure a managed device is required to register security information"
  description   = "Conditional Access (CA) can be configured to enforce access based on the device's compliance status or whether it is Entra hybrid joined. Collectively this allows CA to classify devices as managed or not, providing more granular control over whether or not a user can register MFA on a device."
  query         = query.azuread_conditional_access_require_managed_device_register_security_info
  documentation = file("./cis_v600/docs/cis_v600_5_2_2_10.md")

  tags = merge(local.cis_v600_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.10"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_2_2_11" {
  title         = "5.2.2.11 Ensure sign-in frequency for Intune Enrollment is set to 'Every time'"
  description   = "Sign-in frequency defines the time period before a user is asked to sign in again when attempting to access a resource. The Microsoft Entra ID default configuration for user sign-in frequency is a rolling window of 90 days. The recommended state is a Sign-in frequency of Every time for Microsoft Intune Enrollment Note: Microsoft accounts for a five-minute clock skew when 'every time' is selected in a conditional access policy, ensuring that users are not prompted more frequently than once every five minutes."
  query         = query.azuread_conditional_access_signin_frequency_intune_every_time
  documentation = file("./cis_v600/docs/cis_v600_5_2_2_11.md")

  tags = merge(local.cis_v600_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.11"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_2_2_12" {
  title         = "5.2.2.12 Ensure the device code sign-in flow is blocked"
  description   = "The Microsoft identity platform supports the device authorization grant, which allows users to sign in to input-constrained devices such as a smart TV, IoT device, or a printer. To enable this flow, the device has the user visit a webpage in a browser on another device to sign in. Once the user signs in, the device is able to get access tokens and refresh tokens as needed. The recommended state is to Block access for Device code flow in Conditional Access."
  query         = query.azuread_conditional_access_block_device_code_flow
  documentation = file("./cis_v600/docs/cis_v600_5_2_2_12.md")

  tags = merge(local.cis_v600_5_2_2_common_tags, {
    cis_item_id           = "5.2.2.12"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v600_5_2_3" {
  title = "5.2.3 Authentication Methods"
  children = [
    control.cis_v600_5_2_3_1,
    control.cis_v600_5_2_3_4,
    control.cis_v600_5_2_3_5,
    control.cis_v600_5_2_3_7
  ]

  tags = merge(local.cis_v600_5_2_3_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_2_3_1" {
  title         = "5.2.3.1 Ensure Microsoft Authenticator is configured to protect against MFA fatigue"
  description   = "Microsoft provides supporting settings to enhance the configuration of the Microsoft Authenticator application. These settings provide users with additional information and context when they receive MFA passwordless and push requests, including the geographic location of the request, the requesting application, and a requirement for number matching."
  query         = query.azuread_authentication_method_microsoft_authenticator_mfa_fatigue_protection
  documentation = file("./cis_v600/docs/cis_v600_5_2_3_1.md")

  tags = merge(local.cis_v600_5_2_3_common_tags, {
    cis_item_id           = "5.2.3.1"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_2_3_4" {
  title         = "5.2.3.4 Ensure all member users are 'MFA capable'"
  description   = "Microsoft defines Multifactor authentication capable as being registered and enabled for a strong authentication method. The method must also be allowed by the authentication methods policy."
  query         = query.microsoft_user_mfa_capable
  documentation = file("./cis_v600/docs/cis_v600_5_2_3_4.md")

  tags = merge(local.cis_v600_5_2_3_common_tags, {
    cis_item_id           = "5.2.3.4"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_2_3_5" {
  title         = "5.2.3.5 Ensure weak authentication methods are disabled"
  description   = "Authentication methods support a wide variety of scenarios for signing in to Microsoft 365 resources. Some of these methods are inherently more secure than others but require more investment in time to get users enrolled and operational."
  query         = query.azuread_authentication_method_restrict_insecure_methods
  documentation = file("./cis_v600/docs/cis_v600_5_2_3_5.md")

  tags = merge(local.cis_v600_5_2_3_common_tags, {
    cis_item_id           = "5.2.3.5"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_2_3_7" {
  title         = "5.2.3.7 Ensure the email OTP authentication method is disabled"
  description   = "Authentication methods support a wide variety of scenarios for signing in to Microsoft 365 resources. Some of these methods are inherently more secure than others but require more investment in time to get users enrolled and operational. The email one-time passcode feature is a way to authenticate B2B collaboration users when they can't be authenticated through other means, such as Microsoft Entra ID, Microsoft account (MSA), or social identity providers. When a B2B guest user tries to redeem your invitation or sign in to your shared resources, they can request a temporary passcode, which is sent to their email address. Then they enter this passcode to continue signing in. The recommended state is to Disable email OTP."
  query         = query.azuread_authentication_method_email_otp_disabled
  documentation = file("./cis_v600/docs/cis_v600_5_2_3_7.md")

  tags = merge(local.cis_v600_5_2_3_common_tags, {
    cis_item_id           = "5.2.3.7"
    cis_level             = "2"
    cis_type              = "automated"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v600_5_2_4" {
  title = "5.2.4 Password reset"
  children = [
    control.cis_v600_5_2_4_1
  ]

  tags = merge(local.cis_v600_5_2_4_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_2_4_1" {
  title         = "5.2.4.1 Ensure 'Self service password reset enabled' is set to 'All'"
  description   = "Enabling self-service password reset allows users to reset their own passwords in Entra ID. When users sign in to Microsoft 365, they will be prompted to enter additional contact information that will help them reset their password in the future. If combined registration is enabled additional information, outside of multi-factor, will not be needed. Note: Effective Oct. 1st, 2022, Microsoft will begin to enable combined registration for all users in Entra ID tenants created before August 15th, 2020. Tenants created after this date are enabled with combined registration by default."
  query         = query.azuread_user_sspr_enabled
  documentation = file("./cis_v600/docs/cis_v600_5_2_4_1.md")

  tags = merge(local.cis_v600_5_2_4_common_tags, {
    cis_item_id           = "5.2.4.1"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3,E5"
    service               = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v600_5_3" {
  title = "5.3 ID Governance"
  children = [
    control.cis_v600_5_3_2,
    control.cis_v600_5_3_3
  ]

  tags = merge(local.cis_v600_5_3_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_3_2" {
  title         = "5.3.2 Ensure 'Access reviews' for Guest Users are configured"
  description   = "Access reviews enable administrators to establish an efficient automated process for reviewing group memberships, access to enterprise applications, and role assignments. These reviews can be scheduled to recur regularly, with flexible options for delegating the task of reviewing membership to different members of the organization. Ensure Access reviews for Guest Users are configured to be performed no less frequently than monthly."
  query         = query.azuread_guest_user_access_reviews_configured
  documentation = file("./cis_v600/docs/cis_v600_5_3_2.md")

  tags = merge(local.cis_v600_5_3_common_tags, {
    cis_item_id           = "5.3.2"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E5"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v600_5_3_3" {
  title         = "5.3.3 Ensure 'Access reviews' for privileged roles are configured"
  description   = "Access reviews enable administrators to establish an efficient automated process for reviewing group memberships, access to enterprise applications, and role assignments. These reviews can be scheduled to recur regularly, with flexible options for delegating the task of reviewing membership to different members of the organization. Ensure Access reviews for high privileged Entra ID roles are done monthly or more frequently. These reviews should include at a minimum the roles listed below: • Global Administrator • Exchange Administrator • SharePoint Administrator • Teams Administrator • Security Administrator Note: An access review is created for each role selected after completing the process."
  query         = query.azuread_privileged_roles_access_reviews_configured
  documentation = file("./cis_v600/docs/cis_v600_5_3_3.md")

  tags = merge(local.cis_v600_5_3_common_tags, {
    cis_item_id           = "5.3.3"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E5"
    service               = "Azure/ActiveDirectory"
  })
}

