# smartmontools Cookbook CHANGELOG

This file is used to list changes made in each version of the smartmontools cookbook.

## Unreleased

- Standardise files with files in sous-chefs/repo-management

## 2.0.0 (2020-05-05)

- Depreciated support for centos 6
- Minimum chef version bumped to 13
- Remove `if responds_to?` check around metadata in metadata.rb
- Remove unnecessary long_description metadata from metadata.rb
- Migrate to github actions

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
