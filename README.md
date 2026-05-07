# Smartmontools Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/smartmontools.svg)](https://supermarket.chef.io/cookbooks/smartmontools)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

Provides a `smartmontools` custom resource for installing smartmontools, rendering smartd
configuration, managing optional run.d scripts, and controlling the smartd service.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook
maintainers working together to maintain important cookbooks. To learn more, visit
[sous-chefs.org](https://sous-chefs.org/) or join `#sous-chefs` in the Chef Community Slack.

## Requirements

### Platforms

* AlmaLinux 8+
* Amazon Linux 2023+
* CentOS Stream 9+
* Debian 12+
* Fedora
* openSUSE Leap 15+
* Oracle Linux 8+
* Red Hat Enterprise Linux 8+
* Rocky Linux 8+
* Ubuntu 22.04+

### Chef

* Chef Infra Client 15.3+

### Cookbooks

* none

## Resources

* [smartmontools](documentation/smartmontools.md)

## Migration

This cookbook no longer provides recipes or node attributes. See [migration.md](migration.md) for
the breaking changes and resource migration examples.

## Usage

```ruby
smartmontools 'default'
```

```ruby
smartmontools 'default' do
  devices(
    'sda' => '-H -l error -l selftest -m root@example.com',
    'sdb' => nil
  )
  device_opts '-H -l error -l selftest'
  smartd_opts '--interval=1800'
end
```

## Contributors

This project exists thanks to all the people who
[contribute](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false).

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
