locals {
  cis_v140_2_common_tags = merge(local.cis_v140_common_tags, {
    cis_section_id = "1"
  })
}

benchmark "cis_v140_2" {
  title         = "2 Application Permissions"
  documentation = file("./cis_v140/docs/cis_v140_2.md")
  children = [
    control.cis_v140_2_6
  ]

  tags = merge(local.cis_v140_2_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v140_2_6" {
  title         = "2.6 Ensure user consent to apps accessing company data on their behalf is not allowed."
  description   = "Enable user consent to apps accessing company data on their behalf is not allowed."
  sql           = query.ad_authorization_policy_accessing_company_data_not_allowed.sql
  documentation = file("./cis_v140/docs/cis_v140_2_6.md")

  tags = merge(local.cis_v140_1_common_tags, {
    cis_item_id = "2.6"
    cis_level   = "1"
    cis_type    = "manual"
    service     = "Azure/ActiveDirectory"
  })
}


