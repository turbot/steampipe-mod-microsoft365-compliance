---
repository: "https://github.com/turbot/steampipe-mod-microsoft365-compliance/"
---

# Microsoft 365 Compliance Mod

Run individual configuration, compliance and security controls or full `CIS` compliance benchmarks across all your Microsoft 365 tenants.

<img src="https://raw.githubusercontent.com/turbot/steampipe-mod-microsoft365-compliance/main/docs/microsoft365_compliance_dashboard.png" width="50%" type="thumbnail"/>
<img src="https://raw.githubusercontent.com/turbot/steampipe-mod-microsoft365-compliance/staging/docs/microsoft365_compliance_cis_v140_dashboard.png" width="50%" type="thumbnail"/>
<img src="https://raw.githubusercontent.com/turbot/steampipe-mod-microsoft365-compliance/staging/docs/microsoft365_compliance_cis_v140_terminal.png" width="50%" type="thumbnail"/>

## References

[Microsoft 365](https://www.microsoft.com/microsoft-365) provides office apps, extra cloud storage, advanced security, and many more in one convenient subscription basis.

[Azure](https://azure.microsoft.com) provides on-demand cloud computing platforms and APIs to authenticated customers on a metered pay-as-you-go basis.

[CIS Microsoft 365 Benchmark](https://www.cisecurity.org/benchmark/microsoft_365) provide a predefined set of compliance and security best-practice checks for Microsoft Office 365 usage.

[Steampipe](https://steampipe.io) is an open source CLI to instantly query cloud APIs using SQL.

[Steampipe Mods](https://steampipe.io/docs/reference/mod-resources#mod) are collections of `named queries`, and codified `controls` that can be used to test current configuration of your cloud resources against a desired configuration.

## Documentation

- **[Benchmarks and controls →](https://hub.steampipe.io/mods/turbot/microsoft365_compliance/controls)**
- **[Named queries →](https://hub.steampipe.io/mods/turbot/microsoft365_compliance/queries)**

## Getting started

### Installation

Download and install Steampipe (https://steampipe.io/downloads). Or use Brew:

```sh
brew tap turbot/tap
brew install steampipe
```

Install the Azure Active Directory and the Microsoft 365 plugins with [Steampipe](https://steampipe.io):

```sh
steampipe plugin install azuread
steampipe plugin install microsoft365

```

Clone:

```sh
git clone https://github.com/turbot/steampipe-mod-microsoft365-compliance/.git
cd steampipe-mod-microsoft365-compliance/
```

### Usage

Start your dashboard server to get started:

```sh
steampipe dashboard
```

By default, the dashboard interface will then be launched in a new browser
window at https://localhost:9194. From here, you can run benchmarks by
selecting one or searching for a specific one.

Instead of running benchmarks in a dashboard, you can also run them within your
terminal with the `steampipe check` command:

Run all benchmarks:

```sh
steampipe check all
```

Run a benchmark:

```sh
steampipe check benchmark.cis_v140
```

Run a specific control:

```sh
steampipe check control.cis_v140_1_1_3
```

Different output formats are also available, for more information please see
[Output Formats](https://steampipe.io/docs/reference/cli/check#output-formats).

### Credentials

This mod uses the credentials configured in the Steampipe [Azure AD](https://hub.steampipe.io/plugins/turbot/azuread) and [Microsoft 365](https://hub.steampipe.io/plugins/turbot/microsoft365) plugins.

### Configuration

No extra configuration is required.

## Contributing

If you have an idea for additional controls or just want to help maintain and extend this mod ([or others](https://github.com/topics/steampipe-mod)) we would love you to join the community and start contributing.

- **[Join our Slack community →](https://steampipe.io/community/join)** and hang out with other Mod developers.

Please see the [contribution guidelines](https://github.com/turbot/steampipe/blob/main/CONTRIBUTING.md) and our [code of conduct](https://github.com/turbot/steampipe/blob/main/CODE_OF_CONDUCT.md). All contributions are subject to the [Apache 2.0 open source license](https://github.com/turbot/steampipe-mod-microsoft365-compliance/blob/main/LICENSE).

Want to help but not sure where to start? Pick up one of the `help wanted` issues:

- [Steampipe](https://github.com/turbot/steampipe/labels/help%20wanted)
- [Microsoft 365 Compliance Mod](https://github.com/turbot/steampipe-mod-microsoft365-compliance/labels/help%20wanted)
