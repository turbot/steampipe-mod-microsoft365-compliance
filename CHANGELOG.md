## v1.2.0 [2025-02-14]

_What's new?_

- Added CIS v4.0.0 benchmark (`powerpipe benchmark run benchmark.cis_v400`). ([#76](https://github.com/turbot/steampipe-mod-microsoft365-compliance/pull/76))


## v1.0.1 [2024-10-24]

_Bug fixes_

- Renamed `steampipe.spvars.example` files to `powerpipe.ppvars.example` and updated documentation. ([#73](https://github.com/turbot/steampipe-mod-microsoft365-compliance/pull/73))

## v1.0.0 [2024-10-22]

This mod now requires [Powerpipe](https://powerpipe.io). [Steampipe](https://steampipe.io) users should check the [migration guide](https://powerpipe.io/blog/migrating-from-steampipe).

## v0.10 [2024-03-06]

_Powerpipe_

[Powerpipe](https://powerpipe.io) is now the preferred way to run this mod!  [Migrating from Steampipe →](https://powerpipe.io/blog/migrating-from-steampipe)

All v0.x versions of this mod will work in both Steampipe and Powerpipe, but v1.0.0 onwards will be in Powerpipe format only.

_Enhancements_

- Focus documentation on Powerpipe commands.
- Show how to combine Powerpipe mods with Steampipe plugins.

## v0.9 [2023-11-14]

_What's new?_

- Added CIS v3.0.0 benchmark (`steampipe check benchmark.cis_v300`). ([#57](https://github.com/turbot/steampipe-mod-microsoft365-compliance/pull/57))

## v0.8 [2023-11-09]

_Breaking changes_

- Updated the plugin dependency section of the mod to use `min_version` instead of `version`. ([#55](https://github.com/turbot/steampipe-mod-microsoft365-compliance/pull/55))

## v0.7 [2023-06-07]

_Bug fixes_

- Fixed the broken query link for [`cis_v200_1_1_21`](https://hub.steampipe.io/mods/turbot/microsoft365_compliance/controls/control.cis_v200_1_1_21?context=benchmark.cis_v200/benchmark.cis_v200_1/benchmark.cis_v200_1_1) control on the hub. ([#49](https://github.com/turbot/steampipe-mod-microsoft365-compliance/pull/49))

## v0.6 [2023-05-25]

_Dependencies_

- Azuread plugin `v0.10.0` or higher is now required. ([#44](https://github.com/turbot/steampipe-mod-microsoft365-compliance/pull/44))

_What's new?_

- Added `tags` as dimensions to group and filter findings. (see [var.common_dimensions](https://hub.steampipe.io/mods/turbot/microsoft365_compliance/variables)) ([#40](https://github.com/turbot/steampipe-mod-microsoft365-compliance/pull/40))
- Added `connection_name` in the common dimensions to group and filter findings. (see [var.common_dimensions](https://hub.steampipe.io/mods/turbot/microsoft365_compliance/variables)) ([#40](https://github.com/turbot/steampipe-mod-microsoft365-compliance/pull/40))

_Bug fixes_

- Fixed dashboard localhost URLs in README and index doc. ([#45](https://github.com/turbot/steampipe-mod-microsoft365-compliance/pull/45))

## v0.5 [2023-05-12]

_What's new?_

- Added CIS v2.0.0 benchmark (`steampipe check benchmark.cis_v200`)
- Added CIS v1.5.0 benchmark (`steampipe check benchmark.cis_v150`)

## v0.4 [2023-04-11]

_Bug fixes_

- Remove the following unused queries referencing `microsoft365_sharepoint_setting` table. ([#34](https://github.com/turbot/steampipe-mod-microsoft365-compliance/pull/34))
  - `microsoft365_auth_sharepoint_applications`
  - `microsoft365_block_onedrive_business_sync`
  - `microsoft365_domain_sharing_restriction_mode`
  - `microsoft365_resharing_by_external_users_enabled`

## v0.3 [2022-12-22]

_Bug fixes_

- Fixed incorrect git clone commands in README and index document. ([#28](https://github.com/turbot/steampipe-mod-microsoft365-compliance/pull/28)) (Thanks to [@Andrew-Bennett](https://github.com/Andrew-Bennett) for the fixes!)

## v0.2 [2022-10-14]

_Bug fixes_

- Fixed incorrect references to social graphic images in the `mod.sp` file. ([#25](https://github.com/turbot/steampipe-mod-microsoft365-compliance/pull/25))

## v0.1 [2022-10-13]

_What's new?_

- Added CIS v1.4.0 benchmark (`steampipe check benchmark.cis_v140`)
