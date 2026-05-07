# frozen_string_literal: true

smartmontools 'default' do
  devices(
    'sda' => '-H -l error -l selftest -m root'
  )
  smartd_opts '--interval=1800'
  service_actions [:enable]
  action :create
end
