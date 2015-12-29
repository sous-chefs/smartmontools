#
# Cookbook Name:: smartmontools
# Recipe:: default
#
# Copyright 2011-2015, Joshua Timberman
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# exit if running on virtualized or cloud nodes.
return if (
  node['virtualization'] && node['virtualization']['role'] == 'guest'
) || node['cloud']

# set appropriate service name based on platform_family
service_name = value_for_platform_family(
  'rhel' => 'smartd',
  'default' => 'smartmontools'
)

# set default directory based on platform
default_dir = value_for_platform_family(
  'rhel' => 'sysconfig',
  'default' => 'default'
)

package 'smartmontools'

template "/etc/#{default_dir}/smartmontools" do
  source 'smartmontools.default.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, "service[#{service_name}]"
end

# manage debian / ubuntu specific files
if platform_family?('debian')
  node['smartmontools']['run_d'].each do |rund|
    cookbook_file "/etc/smartmontools/run.d/#{rund}" do
      source rund
      owner 'root'
      group 'root'
      mode '0755'
    end
  end
end

template '/etc/smartd.conf' do
  source 'smartd.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, "service[#{service_name}]"
end

service service_name do
  supports status: true, reload: true, restart: true
  action [:enable, :start]
end
