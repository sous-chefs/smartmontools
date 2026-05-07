# frozen_string_literal: true

title 'smartmontools default resource'

control 'smartmontools-package-01' do
  impact 1.0
  title 'Package is installed'

  describe package('smartmontools') do
    it { should be_installed }
  end
end

control 'smartmontools-config-01' do
  impact 1.0
  title 'Configuration files are rendered'

  describe file('/etc/smartd.conf') do
    it { should exist }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0644' }
    its('content') { should match %r{/dev/sda -H -l error -l selftest -m root} }
  end

  describe.one do
    describe file('/etc/default/smartmontools') do
      it { should exist }
      its('content') { should match(/smartd_opts="--interval=1800"/) }
    end

    describe file('/etc/sysconfig/smartmontools') do
      it { should exist }
      its('content') { should match(/smartd_opts="--interval=1800"/) }
    end
  end
end

control 'smartmontools-service-01' do
  impact 1.0
  title 'Service is enabled'

  describe.one do
    describe service('smartmontools') do
      it { should be_enabled }
    end

    describe service('smartd') do
      it { should be_enabled }
    end
  end
end
