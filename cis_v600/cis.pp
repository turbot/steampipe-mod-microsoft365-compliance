locals {
  cis_v600_common_tags = merge(local.microsoft365_compliance_common_tags, {
    cis         = "true"
    cis_version = "v6.0.0"
  })
}

benchmark "cis_v600" {
  title         = "Microsoft 365 CIS v6.0.0"
  description   = "The CIS Microsoft 365 Security Configuration Benchmark provides prescriptive guidance for establishing a secure configuration posture for Microsoft 365 Cloud offerings running on any OS."
  documentation = file("./cis_v600/docs/cis_overview.md")

  children = [
    benchmark.cis_v600_1,
    benchmark.cis_v600_3,
    benchmark.cis_v600_5,
    benchmark.cis_v600_7
  ]

  tags = merge(local.cis_v600_common_tags, {
    type = "Benchmark"
  })
}

