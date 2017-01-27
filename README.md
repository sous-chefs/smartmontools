# Smartmontools Cookbook
[![Build Status](https://travis-ci.org/sous-chefs/smartmontools.svg?branch=master)](https://travis-ci.org/sous-chefs/smartmontools) [![Cookbook Version](https://img.shields.io/cookbook/v/smartmontools.svg)](https://supermarket.chef.io/cookbooks/smartmontools)

This cookbook will install the smartmontools package and enable the service. It will also configure default email reports.

## Requirements
### Platforms
- Ubuntu 12.04+
- RHEL family (Redhat Enterprise, CentOS, etc)
- Debian 6.0+

### Chef
- Chef 11+

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

```
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

```
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

```
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

## License & Authors
Copyright 2011-2015, Joshua Timberman ([cookbooks@housepub.org](mailto:cookbooks@housepub.org))

```text
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
