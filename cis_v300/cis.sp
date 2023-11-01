locals {
  cis_v300_common_tags = merge(local.microsoft365_compliance_common_tags, {
    cis         = "true"
    cis_version = "v3.0.0"
  })
}

benchmark "cis_v300" {
  title         = "CIS v3.0.0"
  description   = "The CIS Microsoft 365 Security Configuration Benchmark provides prescriptive guidance for establishing a secure configuration posture for Microsoft 365 Cloud offerings running on any OS."
  documentation = file("./cis_v300/docs/cis_overview.md")

  children = [
    benchmark.cis_v300_1,
    benchmark.cis_v300_2,
    benchmark.cis_v300_5
  ]

  tags = merge(local.cis_v300_common_tags, {
    type = "Benchmark"
  })
}
