// Benchmarks and controls for specific services should override the "service" tag
locals {
  microsoft_365_compliance_common_tags = {
    category = "Compliance"
    plugin   = "azure"
    service  = "Azure"
  }
}

mod "microsoft_365_foundations_compliance" {
  # hub metadata
  title         = "Microsoft 365 Foundations Compliance"
  description   = "Run individual configuration, compliance and security controls or full compliance benchmarks for Microsoft Office 365 Foundations."
  color         = "#00A4EF"
  documentation = file("./docs/index.md")
  categories = ["azure", "cis", "compliance", "security"]

  opengraph {
    title       = "Steampipe Mod for Microsoft 365 Compliance"
    description = "Run individual configuration, compliance and security controls or full compliance benchmarks for Microsoft Office 365 Foundations."
    image       = "/images/mods/turbot/microsoft-365-social-graphic.png"
  }
}
