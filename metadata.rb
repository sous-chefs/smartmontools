name             'smartmontools'
maintainer       'Sous Chefs'
maintainer_email 'help@sous-chefs.org'
license          'Apache 2.0'
description      'Installs and configures smartmontools'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.2'

supports 'debian', '>= 7.0'
supports 'ubuntu', '>= 12.04'
supports 'centos', '>= 5.7'
supports 'redhat', '>= 5.7'
supports 'scientific'
supports 'oracle'
source_url 'https://github.com/jtimberman/smartmontools-cookbook' if respond_to?(:source_url)
issues_url 'https://github.com/jtimberman/smartmontools-cookbook/issues' if respond_to?(:issues_url)
