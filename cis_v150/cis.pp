locals {
  cis_v150_common_tags = merge(local.microsoft365_compliance_common_tags, {
    cis         = "true"
    cis_version = "v1.5.0"
  })
}

benchmark "cis_v150" {
  title         = "Microsoft 365 CIS v1.5.0"
  description   = "The CIS Microsoft 365 Security Configuration Benchmark provides prescriptive guidance for establishing a secure configuration posture for Microsoft 365 Cloud offerings running on any OS."
  documentation = file("./cis_v150/docs/cis_overview.md")

  children = [
    benchmark.cis_v150_1,
    benchmark.cis_v150_2,
    benchmark.cis_v150_5
  ]

  tags = merge(local.cis_v150_common_tags, {
    type = "Benchmark"
  })
}
