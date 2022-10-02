locals {
  cis_v140_common_tags = merge(local.microsoft365_compliance_common_tags, {
    cis         = "true"
    cis_version = "v1.4.0"
  })
}

benchmark "cis_v140" {
  title         = "CIS v1.4.0"
  description   = "The CIS Microsoft 365 Security Configuration Benchmark provides prescriptive guidance for establishing a secure configuration posture for Microsoft 365 Cloud offerings running on any OS."
  documentation = file("./cis_v140/docs/cis_overview.md")

  children = [
    benchmark.cis_v140_1,
    benchmark.cis_v140_2,
    benchmark.cis_v140_3,
    benchmark.cis_v140_4,
    benchmark.cis_v140_5,
    benchmark.cis_v140_6,
    benchmark.cis_v140_7
  ]

  tags = merge(local.cis_v140_common_tags, {
    type = "Benchmark"
  })
}
