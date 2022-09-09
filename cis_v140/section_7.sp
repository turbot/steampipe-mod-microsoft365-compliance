locals {
  cis_v140_7_common_tags = merge(local.cis_v140_common_tags, {
    cis_section_id = "7"
  })
}

benchmark "cis_v140_7" {
  title         = "7 Mobile Device Management"
  documentation = file("./cis_v140/docs/cis_v140_7.md")
  children = [
    control.cis_v140_7_1,
    control.cis_v140_7_2,
    control.cis_v140_7_3,
    control.cis_v140_7_4,
    control.cis_v140_7_5,
    control.cis_v140_7_6,
    control.cis_v140_7_7,
    control.cis_v140_7_8,
    control.cis_v140_7_9,
    control.cis_v140_7_10,
    control.cis_v140_7_11,
    control.cis_v140_7_12,
    control.cis_v140_7_13
  ]

  tags = merge(local.cis_v140_7_common_tags, {
    type    = "Benchmark"
    service = "Azure/ActiveDirectory"
  })
}

control "cis_v140_7_1" {
  title         = "7.1 Ensure mobile device management polices are set to require advanced security configurations to protect from basic internet attacks"
  description   = "You should configure your mobile device management policies to require advanced security configurations. If you do not require this, users will be able to connect from devices that are vulnerable to basic internet attacks, leading to potential breaches of accounts and data."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_7_1.md")

  tags = merge(local.cis_v140_7_common_tags, {
    cis_item_id = "7.1"
    cis_level   = "1"
    cis_type    = "manual"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_7_2" {
  title         = "7.2 Ensure that mobile device password reuse is prohibited"
  description   = "You should not allow your users to reuse the same password on their mobile devices."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_7_2.md")

  tags = merge(local.cis_v140_7_common_tags, {
    cis_item_id = "7.2"
    cis_level   = "1"
    cis_type    = "manual"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_7_3" {
  title         = "7.3 Ensure that mobile devices are set to never expire passwords"
  description   = "Ensure that users passwords on their mobile devices, never expire."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_7_3.md")

  tags = merge(local.cis_v140_7_common_tags, {
    cis_item_id = "7.3"
    cis_level   = "1"
    cis_type    = "manual"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_7_4" {
  title         = "7.4 Ensure that users cannot connect from devices that are jail broken or rooted"
  description   = "You should not allow your users to use to connect with mobile devices that have been jail broken or rooted."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_7_4.md")

  tags = merge(local.cis_v140_7_common_tags, {
    cis_item_id = "7.4"
    cis_level   = "1"
    cis_type    = "manual"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_7_5" {
  title         = "7.5 Ensure mobile devices are set to wipe on multiple sign-in failures to prevent brute force compromise"
  description   = "Require mobile devices to wipe on multiple sign-in failures."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_7_5.md")

  tags = merge(local.cis_v140_7_common_tags, {
    cis_item_id = "7.5"
    cis_level   = "2"
    cis_type    = "manual"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_7_6" {
  title         = "7.6 Ensure that mobile devices require a minimum password length to prevent brute force attacks"
  description   = "You should require your users to use a minimum password length of at least six characters to unlock their mobile devices."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_7_6.md")

  tags = merge(local.cis_v140_7_common_tags, {
    cis_item_id = "7.6"
    cis_level   = "1"
    cis_type    = "manual"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_7_7" {
  title         = "7.7 Ensure that settings are enable to lock devices after a period of inactivity to prevent unauthorized access"
  description   = "You should require your users to configure their mobile devices to lock on inactivity."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_7_7.md")

  tags = merge(local.cis_v140_7_common_tags, {
    cis_item_id = "7.7"
    cis_level   = "1"
    cis_type    = "manual"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_7_8" {
  title         = "7.8 Ensure that mobile device encryption is enabled to prevent unauthorized access to mobile data"
  description   = "You should require your users to use encryption on their mobile devices."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_7_8.md")

  tags = merge(local.cis_v140_7_common_tags, {
    cis_item_id = "7.8"
    cis_level   = "1"
    cis_type    = "manual"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_7_9" {
  title         = "7.9 Ensure that mobile devices require complex passwords (Type = Alphanumeric)"
  description   = "You should require your users to use a complex password with a at least two character sets (letters and numbers, for example) to unlock their mobile devices."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_7_9.md")

  tags = merge(local.cis_v140_7_common_tags, {
    cis_item_id = "7.9"
    cis_level   = "1"
    cis_type    = "manual"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_7_10" {
  title         = "7.10 Ensure that mobile devices require complex passwords (Simple Passwords = Blocked)"
  description   = "You should require your users to use a complex password to unlock their mobile devices."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_7_10.md")

  tags = merge(local.cis_v140_7_common_tags, {
    cis_item_id = "7.10"
    cis_level   = "1"
    cis_type    = "manual"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_7_11" {
  title         = "7.11 Ensure that devices connecting have AV and a local firewall enabled"
  description   = "You should configure your mobile device management policies to require the PC to have anti-virus and have a firewall enabled."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_7_11.md")

  tags = merge(local.cis_v140_7_common_tags, {
    cis_item_id = "7.11"
    cis_level   = "1"
    cis_type    = "manual"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_7_12" {
  title         = "7.12 Ensure mobile device management policies are required for email profiles"
  description   = "You should configure your mobile device management policies to require the policy to manage the email profile of the user."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_7_12.md")

  tags = merge(local.cis_v140_7_common_tags, {
    cis_item_id = "7.12"
    cis_level   = "2"
    cis_type    = "manual"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}

control "cis_v140_7_13" {
  title         = "7.13 Ensure mobile devices require the use of a password"
  description   = "You should require your users to use a password to unlock their mobile devices."
  sql           = query.ad_manual_control.sql
  documentation = file("./cis_v140/docs/cis_v140_7_13.md")

  tags = merge(local.cis_v140_7_common_tags, {
    cis_item_id = "7.13"
    cis_level   = "1"
    cis_type    = "manual"
    license     = "E3"
    service     = "Azure/ActiveDirectory"
  })
}
