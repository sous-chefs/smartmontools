# frozen_string_literal: true

provides :smartmontools
unified_mode true

property :package_name, String, default: 'smartmontools'
property :service_name, String, default: lazy {
  if platform_family?('rhel', 'fedora', 'amazon')
    'smartd'
  else
    'smartmontools'
  end
}
property :default_config_path, String, default: lazy {
  config_dir = if platform_family?('rhel', 'fedora', 'amazon')
                 'sysconfig'
               else
                 'default'
               end

  "/etc/#{config_dir}/smartmontools"
}
property :config_path, String, default: '/etc/smartd.conf'
property :start_smartd, [String, true, false], default: 'yes'
property :smartd_opts, String, default: ''
property :devices, [Array, Hash], default: []
property :device_opts, String, default: '-H -l error -l selftest'
property :run_d, Hash, default: {
  '10mail' => <<~'SCRIPT',
    #!/bin/bash -e

    # Send mail if /usr/bin/mail exists or exit silently
    [ -x /usr/bin/mail ] || exit 0

    input=$1
    shift

    /usr/bin/mail "$@" < $input
  SCRIPT
}
property :run_d_path, String, default: '/etc/smartmontools/run.d'
property :manage_run_d, [true, false], default: lazy { platform_family?('debian') }
property :service_actions, Array, default: %i(enable start), desired_state: false
property :remove_package, [true, false], default: true, desired_state: false

default_action :create

action :create do
  package new_resource.package_name

  template new_resource.default_config_path do
    cookbook 'smartmontools'
    source 'smartmontools.default.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      smartd_opts: new_resource.smartd_opts,
      start_smartd: new_resource.start_smartd
    )
    notifies :reload, "service[#{new_resource.service_name}]", :delayed
  end

  if new_resource.manage_run_d
    directory new_resource.run_d_path do
      owner 'root'
      group 'root'
      mode '0755'
      recursive true
    end

    new_resource.run_d.each do |filename, content|
      file ::File.join(new_resource.run_d_path, filename) do
        content content
        owner 'root'
        group 'root'
        mode '0755'
      end
    end
  end

  template new_resource.config_path do
    cookbook 'smartmontools'
    source 'smartd.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      devices: new_resource.devices,
      device_opts: new_resource.device_opts
    )
    notifies :reload, "service[#{new_resource.service_name}]", :delayed
  end

  service new_resource.service_name do
    supports status: true, reload: true, restart: true
    action new_resource.service_actions
  end
end

action :delete do
  service new_resource.service_name do
    supports status: true, reload: true, restart: true
    action %i(stop disable)
  end

  file new_resource.config_path do
    action :delete
  end

  file new_resource.default_config_path do
    action :delete
  end

  if new_resource.manage_run_d
    new_resource.run_d.each_key do |filename|
      file ::File.join(new_resource.run_d_path, filename) do
        action :delete
      end
    end
  end

  package new_resource.package_name do
    action :remove
    only_if { new_resource.remove_package }
  end
end
