name             'smartmontools'
maintainer       'Sous Chefs'
maintainer_email 'help@sous-chefs.org'
license          'Apache-2.0'
description      'Installs and configures smartmontools'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.1.0'

%w(ubuntu debian redhat centos fedora scientific oracle).each do |os|
  supports os
end

chef_version '>= 12' if respond_to?(:chef_version)
source_url 'https://github.com/sous-chefs/smartmontools'
issues_url 'https://github.com/sous-chefs/smartmontools/issues'
