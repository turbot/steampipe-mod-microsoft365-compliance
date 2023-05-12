# Microsoft 365 Compliance Mod for Steampipe

20+ checks covering industry defined security best practices for Microsoft 365. Includes full support for `CIS v1.4`,`CIS v1.5` and `CIS v2.0` compliance benchmarks across all of your Microsoft 365 tenants.

**Includes full support for the CIS v1.4.0 Microsoft 365 benchmarks**.

Run checks in a dashboard:
![image](https://raw.githubusercontent.com/turbot/steampipe-mod-microsoft365-compliance/main/docs/microsoft365_compliance_dashboard.png)

Or in a terminal:
![image](https://raw.githubusercontent.com/turbot/steampipe-mod-microsoft365-compliance/main/docs/microsoft365_compliance_cis_v140_terminal.png)

Includes support for:

* [Microsoft 365 CIS v1.4.0](https://hub.steampipe.io/mods/turbot/microsoft365_compliance/controls/benchmark.cis_v140)
* [Microsoft 365 CIS v1.5.0](https://hub.steampipe.io/mods/turbot/microsoft365_compliance/controls/benchmark.cis_v150) 🚀 New!
* [Microsoft 365 CIS v2.0.0](https://hub.steampipe.io/mods/turbot/microsoft365_compliance/controls/benchmark.cis_v200) 🚀 New!


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
git clone https://github.com/turbot/steampipe-mod-microsoft365-compliance.git
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

Run a single benchmark:

```sh
steampipe check benchmark.cis_v140_1
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

If you have an idea for additional compliance controls, or just want to help maintain and extend this mod ([or others](https://github.com/topics/steampipe-mod)) we would love you to join the community and start contributing. (Even if you just want to help with the docs.)

- **[Join our Slack community →](https://steampipe.io/community/join)** and hang out with other Mod developers.

Please see the [contribution guidelines](https://github.com/turbot/steampipe/blob/main/CONTRIBUTING.md) and our [code of conduct](https://github.com/turbot/steampipe/blob/main/CODE_OF_CONDUCT.md). All contributions are subject to the [Apache 2.0 open source license](https://github.com/turbot/steampipe-mod-microsoft365-compliance/blob/main/LICENSE).

Want to help but not sure where to start? Pick up one of the `help wanted` issues:

- [Steampipe](https://github.com/turbot/steampipe/labels/help%20wanted)
- [Microsoft 365 Compliance Mod](https://github.com/turbot/steampipe-mod-microsoft365-compliance/labels/help%20wanted)
