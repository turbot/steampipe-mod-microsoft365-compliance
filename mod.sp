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
  description   = "Run individual configuration, compliance and security controls or full compliance benchmarks for CIS, FFIEC, PCI, NIST, HIPAA, RBI CSF, GDPR, SOC 2, Audit Manager Control Tower, FedRAMP, GxP and AWS Foundational Security Best Practices controls across all your AWS accounts using Steampipe."
  # color         = "#FF9900"
  documentation = file("./docs/index.md")
  icon          = "/images/mods/turbot/aws-compliance.svg"
  categories    = ["azure", "cis", "compliance", "public cloud", "security"]

  opengraph {
    title       = "Steampipe Mod for AWS Compliance"
    description = "Run individual configuration, compliance and security controls or full compliance benchmarks for CIS, FFIEC, PCI, NIST, HIPAA, RBI CSF, GDPR, SOC 2, Audit Manager Control Tower, FedRAMP, GxP and AWS Foundational Security Best Practices controls across all your AWS accounts using Steampipe."
    image       = "/images/mods/turbot/aws-compliance-social-graphic.png"
  }

  require {
    plugin "aws" {
      version = "0.71.0"
    }
  }
}