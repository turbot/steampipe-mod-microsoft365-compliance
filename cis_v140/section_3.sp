locals {
  cis_v140_3_common_tags = merge(local.cis_v140_common_tags, {
    cis_section_id = "1"
  })
}

benchmark "cis_v140_3" {
  title         = "3 Data Management"
  documentation = file("./cis_v140/docs/cis_v140_3.md")
  children = [
    control.cis_v140_3_1
  ]

  tags = merge(local.cis_v140_3_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v140_3_1" {
  title         = "3 demo control"
  description   = "demo"
  sql           = query.manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_2_6.md")

  tags = merge(local.cis_v140_1_common_tags, {
    cis_item_id = "3.1"
    cis_level   = "1"
    cis_type    = "manual"
    service     = "Azure/ActiveDirectory"
  })
}