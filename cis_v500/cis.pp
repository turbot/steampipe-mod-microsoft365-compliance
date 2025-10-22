locals {
  cis_v500_common_tags = merge(local.microsoft365_compliance_common_tags, {
    cis         = "true"
    cis_version = "v5.0.0"
  })
}

benchmark "cis_v500" {
  title         = "Microsoft 365 CIS v5.0.0"
  description   = "The CIS Microsoft 365 Security Configuration Benchmark provides prescriptive guidance for establishing a secure configuration posture for Microsoft 365 Cloud offerings running on any OS."
  documentation = file("./cis_v500/docs/cis_overview.md")

  children = [
    benchmark.cis_v500_1,
    benchmark.cis_v500_3,
    benchmark.cis_v500_5,
    benchmark.cis_v500_7
  ]

  tags = merge(local.cis_v500_common_tags, {
    type = "Benchmark"
  })
}

