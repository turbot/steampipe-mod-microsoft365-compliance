mod "microsoft365_compliance" {
  # Hub metadata
  title         = "Microsoft 365 Compliance"
  description   = "Run individual configuration, compliance and security controls or full CIS compliance benchmarks across all of your Microsoft 365 tenants using Powerpipe and Steampipe."
  color         = "#00A4EF"
  documentation = file("./docs/index.md")
  icon          = "/images/mods/turbot/mircosoft365-compliance.svg"
  categories    = ["microsoft365", "cis", "compliance", "security"]

  opengraph {
    title       = "Powerpipe Mod for Microsoft 365 Compliance"
    description = "Run individual configuration, compliance and security controls or full CIS compliance benchmarks across all of your Microsoft 365 tenants using Powerpipe and Steampipe."
    image       = "/images/mods/turbot/mircosoft365-compliance-social-graphic.png"
  }

  require {
    plugin "azuread" {
      min_version = "0.10.0"
    }
    plugin "microsoft365" {
      min_version = "0.0.1"
    }
  }
}
