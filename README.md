# Microsoft 365 Compliance Mod for Steampipe

> [!IMPORTANT]  
> Steampipe mods are [migrating to Powerpipe format](https://powerpipe.io) to gain new features. This mod currently works with both Steampipe and Powerpipe, but will only support Powerpipe from v1.x onward.

20+ checks covering industry defined security best practices for Microsoft 365. Includes full support for `CIS v1.4`,`CIS v1.5`,`CIS v2.0` and `CIS v3.0.0` compliance benchmarks across all of your Microsoft 365 tenants.

**Includes full support for the CIS v1.4.0 Microsoft 365 benchmarks**.

Run checks in a dashboard:
![image](https://raw.githubusercontent.com/turbot/steampipe-mod-microsoft365-compliance/add-new-checks/docs/microsoft365_compliance_dashboard.png)

Or in a terminal:
![image](https://raw.githubusercontent.com/turbot/steampipe-mod-microsoft365-compliance/add-new-checks/docs/microsoft365_compliance_cis_v300_terminal.png)

Includes support for:

* [Microsoft 365 CIS v1.4.0](https://hub.steampipe.io/mods/turbot/microsoft365_compliance/controls/benchmark.cis_v140)
* [Microsoft 365 CIS v1.5.0](https://hub.steampipe.io/mods/turbot/microsoft365_compliance/controls/benchmark.cis_v150)
* [Microsoft 365 CIS v2.0.0](https://hub.steampipe.io/mods/turbot/microsoft365_compliance/controls/benchmark.cis_v200)
* [Microsoft 365 CIS v3.0.0](https://hub.steampipe.io/mods/turbot/microsoft365_compliance/controls/benchmark.cis_v300) 🚀 New!

## Documentation

- **[Benchmarks and controls →](https://hub.powerpipe.io/mods/turbot/aws_compliance/controls)**
- **[Named queries →](https://hub.powerpipe.io/mods/turbot/aws_compliance/queries)**

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

Steampipe will automatically use your default Microsoft 365 credentials. Optionally, you can [setup multiple accounts](https://hub.steampipe.io/plugins/turbot/microsoft365#multi-account-connections) or [customize Microsoft 365 credentials](https://hub.steampipe.io/plugins/turbot/microsoft365#configuring-microsoft365-credentials) or [customize Azure AD credentials](https://hub.steampipe.io/plugins/turbot/microsoft365#configuring-microsoft365-credentials).

Finally, install the mod:

```sh
mkdir dashboards
cd dashboards
powerpipe mod init
powerpipe mod install github.com/turbot/powerpipe-mod-office365-compliance
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
cp powerpipe.ppvar.example powerpipe.ppvars
vi powerpipe.ppvars
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

- [Steampipe](https://github.com/turbot/steampipe/labels/help%20wanted)
- [Microsoft 365 Compliance Mod](https://github.com/turbot/steampipe-mod-microsoft365-compliance/labels/help%20wanted)
