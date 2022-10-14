// Benchmarks and controls for specific services should override the "service" tag
locals {
  microsoft365_compliance_common_tags = {
    category = "Compliance"
    plugin   = "microsoft365"
    service  = "Microsoft365"
  }
}

mod "microsoft365_compliance" {
  # hub metadata
  title         = "Microsoft 365 Compliance"
  description   = "Run individual configuration, compliance and security controls or full CIS compliance benchmarks across all of your Microsoft 365 tenants."
  color         = "#00A4EF"
  documentation = file("./docs/index.md")
  icon          = "/images/mods/turbot/mircosoft365-compliance.svg"
  categories    = ["microsoft365", "cis", "compliance", "security"]

  opengraph {
    title       = "Steampipe Mod for Microsoft 365 Compliance"
    description = "Run individual configuration, compliance and security controls or full CIS compliance benchmarks across all of your Microsoft 365 tenants."
    image       = "/images/mods/turbot/mircosoft365-compliance-social-graphic.png"
  }

  require {
    plugin "azuread" {
      version = "0.8.0"
    }
    plugin "microsoft365" {
      version = "0.0.1"
    }
  }
}
