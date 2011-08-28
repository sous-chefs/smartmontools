#
# Cookbook Name:: smartmontools
# Recipe:: default
#
# Copyright 2011, Joshua Timberman
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

package "smartmontools" do
  action :upgrade
end

template "/etc/default/smartmontools" do
  source "smartmontools.default.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :reload, "service[smartmontools]"
end

template "/etc/smartd.conf" do
  source "smartd.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :reload, "service[smartmontools]"
end

node['smartmontools']['run_d'].each do |rund|

  cookbook_file "/etc/smartmontools/run.d/#{rund}" do
    source rund
    owner "root"
    group "root"
    mode 0755
  end

end

service "smartmontools" do
  supports :status => true, :reload => true, :restart => true
  action [:enable,:start]
end
