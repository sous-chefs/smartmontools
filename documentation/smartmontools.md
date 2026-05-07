# smartmontools

Installs smartmontools, writes smartd configuration, manages optional Debian run.d scripts, and
controls the smartd service.

## Actions

| Action | Description |
|--------|-------------|
| `:create` | Installs and configures smartmontools, then enables and starts the service. Default. |
| `:delete` | Stops and disables the service, removes managed configuration, and removes the package. |

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `package_name` | String | `'smartmontools'` | Package to install. |
| `service_name` | String | platform default | Service to manage. Defaults to `smartd` on RHEL-family platforms and `smartmontools` elsewhere. |
| `default_config_path` | String | platform default | Path for the startup defaults file. Defaults to `/etc/sysconfig/smartmontools` on RHEL-family platforms and `/etc/default/smartmontools` elsewhere. |
| `config_path` | String | `'/etc/smartd.conf'` | Path for the smartd configuration file. |
| `start_smartd` | String, true, false | `'yes'` | Value written to `start_smartd` in the startup defaults file. |
| `smartd_opts` | String | `''` | Extra options passed to smartd in the startup defaults file. |
| `devices` | Array, Hash | `[]` | Devices to monitor. An empty value renders `DEVICESCAN`; a hash maps device names to smartd options. |
| `device_opts` | String | `'-H -l error -l selftest'` | Default options for devices with nil options. |
| `run_d` | Hash | `10mail` script content | Files to render under `run_d_path`, keyed by filename. |
| `run_d_path` | String | `'/etc/smartmontools/run.d'` | Directory for smartd runner scripts. |
| `manage_run_d` | true, false | Debian-family only | Whether to manage `run_d` files. |
| `service_actions` | Array | `[:enable, :start]` | Service actions used by `:create`. |
| `remove_package` | true, false | `true` | Whether `:delete` removes the package. |

## Examples

### Basic Usage

```ruby
smartmontools 'default'
```

### Monitor Explicit Devices

```ruby
smartmontools 'default' do
  devices(
    'sda' => '-H -l error -l selftest -m root@example.com',
    'sdb' => nil
  )
  device_opts '-H -l error -l selftest'
end
```

### Custom run.d Script

```ruby
smartmontools 'default' do
  run_d(
    '99notify' => "#!/bin/sh\nlogger smartd event: $*\n"
  )
end
```
