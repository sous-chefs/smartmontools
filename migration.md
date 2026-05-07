# Migration Guide

Version 3.0 migrates this cookbook from a recipe and node attribute API to the `smartmontools`
custom resource.

## Breaking Changes

* `recipe[smartmontools::default]` has been removed.
* The `attributes/` directory has been removed.
* Node attributes under `node['smartmontools']` are no longer read.
* `files/default` cookbook files are no longer used for run.d scripts.

## Resource Replacement

Replace the old default recipe with an explicit resource declaration:

```ruby
smartmontools 'default'
```

Attribute-driven device configuration now maps to resource properties:

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

The old `node['smartmontools']['run_d']` array is replaced by a `run_d` hash that contains the file
content to render:

```ruby
smartmontools 'default' do
  run_d(
    '10mail' => "#!/bin/bash -e\n[ -x /usr/bin/mail ] || exit 0\ninput=$1\nshift\n/usr/bin/mail \"$@\" < $input\n"
  )
end
```

See [documentation/smartmontools.md](documentation/smartmontools.md) and
[test/cookbooks/test/recipes/default.rb](test/cookbooks/test/recipes/default.rb) for complete
examples.
