# Smartmontools Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/smartmontools.svg)](https://supermarket.chef.io/cookbooks/smartmontools)
[![Build Status](https://img.shields.io/circleci/project/github/sous-chefs/smartmontools/master.svg)](https://circleci.com/gh/sous-chefs/smartmontools)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

This cookbook will install the smartmontools package and enable the service. It will also configure default email reports.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you’d like to know more please visit [sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in [#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Requirements

### Platforms

- Ubuntu
- RHEL family (Redhat Enterprise, CentOS, etc)
- Debian

### Chef

- Chef 13+

### Cookbooks

- none

## Attributes

- `node['smartmontools']['smartd_opts']` - sets the value for the `smartd_opts` in /etc/default/smartmontools. Default is "", which leaves the option commented.
- `node['smartmontools']['start_smartd']` - whether to start smartd service in /etc/default/smartmontools. Default is "yes".
- `node['smartmontools']['devices']` - Array of devices to monitor with the options used in smartd.conf. May also be a hash to provide different options for each device. Default is []. See **Usage**.
- `node['smartmontools']['device_opts']` - If set, these options will be used by default in /etc/smartd.conf for each of the `devices` above. Default is "-H -l error -l selftest".
- `node['smartmontools']['run_d']` - Array of scripts to drop off in `/etc/smartmontools/run.d`. Default is ["10mail"].

## Templates

### /etc/smartd.conf

**Note**: The default /etc/smartd.conf configuration file from the package itself does not recommend using DEVICESCAN, despite it being enabled by default. The template will only use DEVICESCAN if `node['smartmontools']['devices']` is not set.

The template for this file will iterate over the `node['smartmontools']['devices']` attribute and write the configuration out. If no specific options are set for a device, it will get the options from `node['smartmontools']['device_opts']`. See **Usage** below.

### /etc/default/smartmontools

Starts smartd by default using `node['smartmontools']['start_smartd']`. The `enable_smart` option is not recommended by smartmontools per the comment and is not managed via the template. Modify your local copy of the template if you wish to change this.

## Cookbook Files

### /etc/smartmontools/run.d/*

Each filename in the array `node['smartmontools']['run_d']` will be dropped off via a cookbook file. By default the only one is 10mail, which exists, and came from the package. These files should be in `files/default`.

## Usage

By default, the recipe is not set up to monitor any particular devices in smartd.conf, and will use DEVICESCAN. Set the attribute `node['smartmontools']['devices']` to monitor a specific list of disk devices. If you don't require device specific options, this should be an array. A default set of options will be used for all disks from the `node['smartmontools']['device_opts']` attribute.

For example:

```ruby
name "base"
...
default_attributes(
  "smartmontools" => {
    "devices" => ['sda','sdb','sr0'],
    "device_opts" => "-H -l error -l selftest -m root@example.com"
  }
)
```

If you need different configuration options for each device, specify the devices as Hash with the device name as key and the options as value. If the value for a device is nil, the default options from the `node['smartmontools']['device_opts']` attribute are used. For example:

```ruby
name "base"
...
default_attributes(
  "smartmontools" => {
    "devices" => {
      "hda" => "-a -o on -S on -s (S/../.././02|L/../../6/03)",
      "hdb" => nil,
      "hdc" => nil
    },
    "device_opts" => "-H -l error -l selftest -m root@example.com"
  }
)
```

For different kinds of hard drive configurations in your data center, use `default_attributes` in separate roles. For example if web servers have only a single internal disk, but database servers have two disks:

```ruby
name "webserver"
...
default_attributes(
    "smartmontools" => {
      "devices" => ['sda']
    }
)

name "database_server
...
default_attributes(
    "smartmontools" => {
      "devices" => ['sda', "sdb"]
    }
)
```

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

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
