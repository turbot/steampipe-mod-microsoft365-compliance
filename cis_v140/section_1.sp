locals {
  cis_v140_1_common_tags = merge(local.cis_v140_common_tags, {
    cis_section_id = "1"
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

control "cis_v140_1_5" {
  title         = "1.5 Ensure that Office 365 Passwords Are Not Set to Expire."
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

