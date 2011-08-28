Description
===========

Installs and configures smartmontools.

This cookbook will install the smartmontools package and enable the service. It will also configure default email reports.

Requirements
============

## Platform:

Tested on Ubuntu 10.04. Should work on Debian 6.0+ or Ubuntu 10.04+.

Attributes
==========

* `node['smartmontools']['smartd_opts']` - sets the value for the `smartd_opts` in /etc/default/smartmontools. Default is "", which leaves the option commented.
* `node['smartmontools']['start_smartd']` - whether to start smartd service in /etc/default/smartmontools. Default is "yes".
* `node['smartmontools']['devices']` - Array of devices to monitor with the options used in smartd.conf. Default is []. See __Usage__.
* `node['smartmontools']['device_opts']` - If set, these options will be used by default in /etc/smartd.conf for each of the `devices` above. Default is "-H -l error -l selftest".
* `node['smartmontools']['run_d']` - Array of scripts to drop off in `/etc/smartmontools/run.d`. Default is ["10mail"].

Templates
=========

/etc/smartd.conf
----

**Note**: The default /etc/smartd.conf configuration file from the package itself does not recommend using DEVICESCAN, despite it being enabled by default. The template will only use DEVICESCAN if `node['smartmontools']['devices']` is not set.

The template for this file will iterate over the `node['smartmontools']['devices']` attribute and write the configuration out. Each device will get the same options from `node['smartmontools']['device_opts']`. See __Future Plans__ below.

/etc/default/smartmontools
----

Starts smartd by default using `node['smartmontools']['start_smartd']`. The `enable_smart` option is not recommended by smartmontools per the comment and is not managed via the template. Modify your local copy of the template if you wish to change this.

Cookbook Files
==============

/etc/smartmontools/run.d/*
----

Each filename in the array `node['smartmontools']['run_d']` will be dropped off via a cookbook file. By default the only one is 10mail, which exists, and came from the package. These files should be in `files/default`.

Usage
=====

By default, the recipe is not set up to monitor any particular devices in smartd.conf, and will use DEVICESCAN. Set the attribute `node['smartmontools']['devices']` to monitor a specific list of disk devices. This should be an array. A default set of options will be used for all disks from the `node['smartmontools']['device_opts']` attribute.

For example:

    name "base"
    ...
    default_attributes(
      "smartmontools" => {
        "devices" => ['sda','sdb','sr0'],
        "device_opts" => "-H -l error -l selftest -m root@example.com"
      }
    )

For different kinds of hard drive configurations in your data center, use `default_attributes` in separate roles. For example if web servers have only a single internal disk, but database servers have two disks:

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


Future Plans
============

In the future, I'd like to support devices being a hash with options for each device for more flexible configuration. If it is a hash, the key should be the device name, "hda", "hdb", etc, and the value should be the options.

    {
      "hda" => "-a -o on -S on -s (S/../.././02|L/../../6/03)",
      "hdb" => "-H -l error -l selftest -t -I 194",
      "hdc" => "-a -I 194 -W 4,45,55 -R 5 -m admin@example.com"
    }

I might use ohai's detected block devices and whether they are running. This can be a good way to determine candidates for monitoring with smartmontools. To find this information, you can use shef on your system.

    % sudo shef
    chef > node['block_device'].each {|k,v| puts "/dev/#{k}" if v['state']}
    /dev/sda
    /dev/sdb
    /dev/sdc

License and Author
==================

Copyright 2011, Joshua Timberman (<cookbooks@housepub.org>)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
