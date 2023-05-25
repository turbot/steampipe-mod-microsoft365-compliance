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
