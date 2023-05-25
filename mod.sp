// Benchmarks and controls for specific services should override the "service" tag
locals {
  microsoft365_compliance_common_tags = {
    category = "Compliance"
    plugin   = "microsoft365"
    service  = "Microsoft365"
  }
}

variable "common_dimensions" {
  type        = list(string)
  description = "A list of common dimensions to add to each control."
  # Define which common dimensions should be added to each control.
  # - tenant_id
  # - connection_name (_ctx ->> 'connection_name')
  default = ["tenant_id"]
}

variable "tag_dimensions" {
  type        = list(string)
  description = "A list of tags to add as dimensions to each control."
  # A list of tag names to include as dimensions for resources that support
  # tags (e.g. "department", "environment"). Default to empty since tag names are
  # a personal choice
  default = []
}

locals {
  # Local internal variable to build the SQL select clause for common
  # dimensions using a table name qualifier if required. Do not edit directly.
  common_dimensions_qualifier_sql = <<-EOQ
  %{~if contains(var.common_dimensions, "connection_name")}, __QUALIFIER___ctx ->> 'connection_name' as connection_name%{endif~}
  %{~if contains(var.common_dimensions, "tenant_id")}, __QUALIFIER__tenant_id as tenant_id%{endif~}
  EOQ

  # Local internal variable to build the SQL select clause for tag
  # dimensions. Do not edit directly.
  tag_dimensions_qualifier_sql = <<-EOQ
  %{~for dim in var.tag_dimensions},  __QUALIFIER__tags ->> '${dim}' as "${replace(dim, "\"", "\"\"")}"%{endfor~}
  EOQ
}

locals {
  # Local internal variable with the full SQL select clause for common
  # dimensions. Do not edit directly.
  common_dimensions_sql = replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "")
  tag_dimensions_sql    = replace(local.tag_dimensions_qualifier_sql, "__QUALIFIER__", "")
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
