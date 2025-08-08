locals {
  cis_v200_common_tags = merge(local.microsoft365_compliance_common_tags, {
    cis         = "true"
    cis_version = "v2.0.0"
  })
}

benchmark "cis_v200" {
  title         = "Microsoft 365 CIS v2.0.0"
  description   = "The CIS Microsoft 365 Security Configuration Benchmark provides prescriptive guidance for establishing a secure configuration posture for Microsoft 365 Cloud offerings running on any OS."
  documentation = file("./cis_v200/docs/cis_overview.md")

  children = [
    benchmark.cis_v200_1,
    benchmark.cis_v200_2,
    benchmark.cis_v200_5
  ]

  tags = merge(local.cis_v200_common_tags, {
    type = "Benchmark"
  })
}
