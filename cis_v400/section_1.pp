locals {
  cis_v400_1_common_tags = merge(local.cis_v400_common_tags, {
    cis_section_id = "1"
  })
}

locals {
  cis_v400_1_1_common_tags = merge(local.cis_v400_1_common_tags, {
    cis_section_id = "1.1"
  })
}

locals {
  cis_v400_1_2_common_tags = merge(local.cis_v400_1_common_tags, {
    cis_section_id = "1.2"
  })
}

locals {
  cis_v400_1_3_common_tags = merge(local.cis_v400_1_common_tags, {
    cis_section_id = "1.3"
  })
}

benchmark "cis_v400_1" {
  title         = "1 Microsoft 365 admin center"
  documentation = file("./cis_v400/docs/cis_v400_1.md")
  children = [
    benchmark.cis_v400_1_1,
    benchmark.cis_v400_1_2,
    benchmark.cis_v400_1_3

  ]

  tags = merge(local.cis_v400_1_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v400_1_1" {
  title = "1.1 Users"
  children = [
    control.cis_v400_1_1_3
  ]

  tags = merge(local.cis_v400_1_1_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v400_1_1_3" {
  title         = "1.1.3 Ensure that between two and four global admins are designated"
  description   = "More than one global administrator should be designated so a single admin can be monitored and to provide redundancy should a single admin leave an organization. Additionally, there should be no more than four global admins set for any tenant. Ideally global administrators will have no licenses assigned to them."
  query         = query.azuread_global_admin_range_restricted
  documentation = file("./cis_v400/docs/cis_v400_1_1_3.md")

  tags = merge(local.cis_v400_1_1_common_tags, {
    cis_item_id           = "1.1.3"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v400_1_2" {
  title = "1.2 Teams & groups"
  children = [
    control.cis_v400_1_2_1
  ]

  tags = merge(local.cis_v400_1_2_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v400_1_2_1" {
  title         = "1.2.1 Ensure that only organizationally managed/approved public groups exist"
  description   = "Microsoft 365 Groups is the foundational membership service that drives all teamwork across Microsoft 365. With Microsoft 365 Groups, you can give a group of people access to a collection of shared resources. While there are several different group types this recommendation concerns Microsoft 365 Groups. In the Administration panel, when a group is created, the default privacy value is `Public`."
  query         = query.azuread_group_not_public
  documentation = file("./cis_v400/docs/cis_v400_1_2_1.md")

  tags = merge(local.cis_v400_1_2_common_tags, {
    cis_item_id           = "1.2.1"
    cis_level             = "2"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v400_1_3" {
  title = "1.3 Settings"
  children = [
    control.cis_v400_1_3_1,
    control.cis_v400_1_3_3
  ]

  tags = merge(local.cis_v400_1_3_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v400_1_3_1" {
  title         = "1.3.1 Ensure the 'Password expiration policy' is set to 'Set passwords to never expire'"
  description   = "Microsoft cloud-only accounts have a pre-defined password policy that cannot be changed. The only items that can change are the number of days until a password expires and whether or whether passwords expire at all."
  query         = query.azuread_user_password_not_set_to_expire
  documentation = file("./cis_v400/docs/cis_v400_1_3_1.md")

  tags = merge(local.cis_v400_1_3_common_tags, {
    cis_item_id           = "1.3.1"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

control "cis_v400_1_3_3" {
  title         = "1.3.3 Ensure 'External sharing' of calendars is not available"
  description   = "External calendar sharing allows an administrator to enable the ability for users to share calendars with anyone outside of the organization. Outside users will be sent a URL that can be used to view the calendar."
  query         = query.microsoft365_calendar_sharing_disabled
  documentation = file("./cis_v400/docs/cis_v400_1_3_3.md")

  tags = merge(local.cis_v400_1_3_common_tags, {
    cis_item_id           = "1.3.3"
    cis_level             = "2"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}
