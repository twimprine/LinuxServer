name 'LinuxServer'
maintainer 'Thomas Wimprine'
maintainer_email 'twimprin@xula.edu'
license 'MIT'
description 'Installs/Configures LinuxServer'
long_description 'Installs/Configures LinuxServer'
version '0.1.9'
chef_version '>= 12.1' if respond_to?(:chef_version)
supports 'redhat', 'centos', 'ubuntu', 'debian'


# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.com/twimprine/LinuxServer/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/twimprine/LinuxServer'

depends 'resolver', '~> 2.0'
depends 'ntp',      '~> 3.5'
depends 'xula_snmp',     '~> 0.1'
depends 'rsyslog',  '~> 6.0'
# depends 'firewall', '~> 2.0'
depends 'hostsfile', '~> 3.0'
depends 'chef_client_updater', '~> 3.3'
