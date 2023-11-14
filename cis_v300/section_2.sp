locals {
  cis_v300_2_common_tags = merge(local.cis_v300_common_tags, {
    cis_section_id = "2"
  })
}

locals {
  cis_v300_2_3common_tags = merge(local.cis_v300_2_common_tags, {
    cis_section_id = "2.3"
  })
}

benchmark "cis_v300_2" {
  title         = "2 Microsoft 365 Defender"
  documentation = file("./cis_v300/docs/cis_v300_2.md")
  children = [
    benchmark.cis_v300_2_3
  ]

  tags = merge(local.cis_v300_2_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v300_2_3" {
  title = "2.3 Audit"
  children = [
    control.cis_v300_2_3_1
  ]

  tags = merge(local.cis_v300_2_3common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v300_2_3_1" {
  title         = "2.3.1 Ensure the Account Provisioning Activity report is reviewed at least weekly"
  description   = "The Account Provisioning Activity report details any account provisioning that was attempted by an external application."
  query         = query.azuread_account_provisioning_activity_report_reviewed
  documentation = file("./cis_v300/docs/cis_v300_2_3_1.md")

  tags = merge(local.cis_v300_2_3common_tags, {
    cis_item_id           = "2.3.1"
    cis_level             = "1"
    cis_type              = "manual"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}

