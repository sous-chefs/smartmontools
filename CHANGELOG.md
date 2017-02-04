# smartmontools Cookbook CHANGELOG

This file is used to list changes made in each version of the smartmontools cookbook.

## 1.1.0 (2017-02-04)

- Move ownership of the cookbook to the Sous Chefs organization
- Add full integration testing with kitchen-dokken in Travis CI
- Add missing license file
- Don't fail if there is no node['virtualization']
- Add chefignore file to limit which files are uploaded to the chef server
- Add gitignore, berksfile, Gemfile, Rakefile, and rubocop config files
- Added CONTRIBUTING and CODE_OF_CONDUCT files
- Resolve cookstyle warnings
- Add new supermarket metadata
- Remove the init-smartmontools init script that wasn't used anymore
- Remove support for Debian 6 in the metadata since its EoL and we don't support it
- Remove workaround that supported Ubuntu 10.04
