locals {
  cis_v400_3_common_tags = merge(local.cis_v400_common_tags, {
    cis_section_id = "3"
  })
}

locals {
  cis_v400_3_1_common_tags = merge(local.cis_v400_3_common_tags, {
    cis_section_id = "3.1"
  })
}

benchmark "cis_v400_3" {
  title         = "3 Microsoft Purview"
  documentation = file("./cis_v400/docs/cis_v400_3.md")
  children = [
    benchmark.cis_v400_3_1
  ]

  tags = merge(local.cis_v400_3_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v400_3_1" {
  title = "3.1 Audit"
  children = [
    control.cis_v400_3_1_1
  ]

  tags = merge(local.cis_v400_3_1_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v400_3_1_1" {
  title         = "3.1.1 Ensure Microsoft 365 audit log search is Enabled"
  description   = "When audit log search is enabled in the Microsoft Purview compliance portal, user and admin activity within the organization is recorded in the audit log and retained for 90 days. However, some organizations may prefer to use a third-party security information and event management (SIEM) application to access their auditing data. In this scenario, a global admin can choose to turn off audit log search in Microsoft 365."
  query         = query.azuread_audit_log_search_enabled
  documentation = file("./cis_v400/docs/cis_v400_3_1_1.md")

  tags = merge(local.cis_v400_3_1_common_tags, {
    cis_item_id           = "3.1.1"
    cis_level             = "1"
    cis_type              = "automated"
    microsoft_365_license = "E3"
    service               = "Azure/ActiveDirectory"
  })
}
