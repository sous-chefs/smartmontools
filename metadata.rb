name             'smartmontools'
maintainer       'Sous Chefs'
maintainer_email 'help@sous-chefs.org'
license          'Apache-2.0'
description      'Installs and configures smartmontools'
version          '2.0.6'

%w(ubuntu debian redhat centos fedora scientific oracle).each do |os|
  supports os
end

chef_version '>= 13'
source_url 'https://github.com/sous-chefs/smartmontools'
issues_url 'https://github.com/sous-chefs/smartmontools/issues'
