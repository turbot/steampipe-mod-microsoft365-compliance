locals {
  cis_v400_2_common_tags = merge(local.cis_v400_common_tags, {
    cis_section_id = "2"
  })
}

locals {
  cis_v400_2_3common_tags = merge(local.cis_v400_2_common_tags, {
    cis_section_id = "2.3"
  })
}

benchmark "cis_v400_2" {
  title         = "2 Microsoft 365 Defender"
  documentation = file("./cis_v400/docs/cis_v400_2.md")
  children = [
    benchmark.cis_v400_2_3
  ]

  tags = merge(local.cis_v400_2_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

benchmark "cis_v400_2_3" {
  title = "2.3 Audit"
  tags = merge(local.cis_v400_2_3common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}
