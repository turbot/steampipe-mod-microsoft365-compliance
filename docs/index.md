# Microsoft 365 Compliance Mod

Run individual configuration, compliance and security controls or full `CIS` compliance benchmarks across all your Microsoft 365 tenants.

<img src="https://raw.githubusercontent.com/turbot/steampipe-mod-microsoft365-compliance/main/docs/microsoft365_compliance_dashboard.png" width="50%" type="thumbnail"/>
<img src="https://raw.githubusercontent.com/turbot/steampipe-mod-microsoft365-compliance/main/docs/microsoft365_compliance_cis_v300_dashboard.png" width="50%" type="thumbnail"/>
<img src="https://raw.githubusercontent.com/turbot/steampipe-mod-microsoft365-compliance/main/docs/microsoft365_compliance_cis_v300_terminal.png" width="50%" type="thumbnail"/>

## Documentation

- **[Benchmarks and controls →](https://hub.powerpipe.io/mods/turbot/microsoft365_compliance/controls)**
- **[Named queries →](https://hub.powerpipe.io/mods/turbot/microsoft365_compliance/queries)**

## Getting Started

### Installation

Install Powerpipe (https://powerpipe.io/downloads), or use Brew:

```sh
brew install turbot/tap/powerpipe
```

This mod also requires [Steampipe](https://steampipe.io) with the [Microsoft 365 plugin](https://hub.steampipe.io/plugins/turbot/microsoft365) and [Azuread plugin](https://hub.steampipe.io/plugins/turbot/azuread) as the data source. Install Steampipe (https://steampipe.io/downloads), or use Brew:

```sh
brew install turbot/tap/steampipe
steampipe plugin install microsoft365
steampipe plugin install azuread
```

Steampipe will automatically use your default Microsoft 365 credentials. Optionally, you can [setup multiple accounts](https://hub.steampipe.io/plugins/turbot/microsoft365#multi-account-connections) or [customize Microsoft 365 credentials](https://hub.steampipe.io/plugins/turbot/microsoft365#configuring-microsoft365-credentials) or [customize Azure AD credentials](https://hub.steampipe.io/plugins/turbot/azuread#configuring-azuread-credentials).

Finally, install the mod:

```sh
mkdir dashboards
cd dashboards
powerpipe mod init
powerpipe mod install github.com/turbot/steampipe-mod-office365-compliance
```

### Browsing Dashboards

Start Steampipe as the data source:

```sh
steampipe service start
```

Start the dashboard server:

```sh
powerpipe server
```

Browse and view your dashboards at **http://localhost:9033**.

### Running Checks in Your Terminal

Instead of running benchmarks in a dashboard, you can also run them within your
terminal with the `powerpipe benchmark` command:

List available benchmarks:

```sh
powerpipe benchmark list
```

Run a benchmark:

```sh
powerpipe benchmark run microsoft365_compliance.benchmark.cis_v300_1_1
```

Different output formats are also available, for more information please see
[Output Formats](https://powerpipe.io/docs/reference/cli/benchmark#output-formats).

### Common and Tag Dimensions

The benchmark queries use common properties (like `compartment`, `compartment_id`, `connection_name`, `region`, `tenant` and `tenant_id`) and tags that are defined in the form of a default list of strings in the `variables.sp` file. These properties can be overwritten in several ways:

It's easiest to setup your vars file, starting with the sample:

```sh
cp steampipe.spvars.example steampipe.spvars
vi steampipe.spvars
```

Alternatively you can pass variables on the command line:

```sh
powerpipe benchmark run microsoft365_compliance.benchmark.cis_v300_1_1 --var 'common_dimensions=["connection_name", "region", "tenant"]'
```

Or through environment variables:

```sh
export PP_VAR_common_dimensions='["connection_name", "region", "tenant"]'
export PP_VAR_tag_dimensions='["Department", "Environment"]'
powerpipe benchmark run microsoft365_compliance.benchmark.cis_v300_1_1
```

## Open Source & Contributing

This repository is published under the [Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0). Please see our [code of conduct](https://github.com/turbot/.github/blob/main/CODE_OF_CONDUCT.md). We look forward to collaborating with you!

[Steampipe](https://steampipe.io) and [Powerpipe](https://powerpipe.io) are products produced from this open source software, exclusively by [Turbot HQ, Inc](https://turbot.com). They are distributed under our commercial terms. Others are allowed to make their own distribution of the software, but cannot use any of the Turbot trademarks, cloud services, etc. You can learn more in our [Open Source FAQ](https://turbot.com/open-source).

## Get Involved

**[Join #powerpipe on Slack →](https://turbot.com/community/join)**

Want to help but don't know where to start? Pick up one of the `help wanted` issues:

- [Powerpipe](https://github.com/turbot/powerpipe/labels/help%20wanted)
- [Microsoft 365 Compliance Mod](https://github.com/turbot/steampipe-mod-microsoft365-compliance/labels/help%20wanted)
