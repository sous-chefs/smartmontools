# frozen_string_literal: true

require 'spec_helper'

describe 'smartmontools' do
  step_into :smartmontools

  context 'on ubuntu' do
    platform 'ubuntu', '24.04'

    context 'with default properties' do
      recipe do
        smartmontools 'default'
      end

      it { is_expected.to install_package('smartmontools') }
      it { is_expected.to create_template('/etc/default/smartmontools') }
      it { is_expected.to create_template('/etc/smartd.conf') }
      it { is_expected.to create_directory('/etc/smartmontools/run.d') }
      it { is_expected.to create_file('/etc/smartmontools/run.d/10mail') }
      it { is_expected.to enable_service('smartmontools') }
      it { is_expected.to start_service('smartmontools') }

      it do
        expect(chef_run).to render_file('/etc/default/smartmontools')
          .with_content('start_smartd=yes')
      end

      it do
        expect(chef_run).to render_file('/etc/smartd.conf')
          .with_content(%r{^DEVICESCAN -m root -M exec /usr/share/smartmontools/smartd-runner$})
      end
    end

    context 'with device and run.d properties' do
      recipe do
        smartmontools 'default' do
          devices(
            'sda' => '-H -l error -m root',
            'sdb' => nil
          )
          device_opts '-a -m ops@example.com'
          run_d(
            '99custom' => "#!/bin/sh\nexit 0\n"
          )
          smartd_opts '--interval=1800'
        end
      end

      it do
        expect(chef_run).to render_file('/etc/smartd.conf')
          .with_content(%r{^/dev/sda -H -l error -m root$})
      end

      it do
        expect(chef_run).to render_file('/etc/smartd.conf')
          .with_content(%r{^/dev/sdb -a -m ops@example.com$})
      end

      it do
        expect(chef_run).to render_file('/etc/default/smartmontools')
          .with_content('smartd_opts="--interval=1800"')
      end

      it { is_expected.to create_file('/etc/smartmontools/run.d/99custom').with(content: "#!/bin/sh\nexit 0\n") }
    end

    context 'delete action' do
      recipe do
        smartmontools 'default' do
          action :delete
        end
      end

      it { is_expected.to stop_service('smartmontools') }
      it { is_expected.to disable_service('smartmontools') }
      it { is_expected.to delete_file('/etc/smartd.conf') }
      it { is_expected.to delete_file('/etc/default/smartmontools') }
      it { is_expected.to delete_file('/etc/smartmontools/run.d/10mail') }
      it { is_expected.to remove_package('smartmontools') }
    end
  end

  context 'on almalinux' do
    platform 'almalinux', '9'

    recipe do
      smartmontools 'default'
    end

    it { is_expected.to create_template('/etc/sysconfig/smartmontools') }
    it { is_expected.to enable_service('smartd') }
    it { is_expected.to start_service('smartd') }
    it { is_expected.not_to create_directory('/etc/smartmontools/run.d') }
  end
end
