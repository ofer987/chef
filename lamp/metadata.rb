name 'lamp'
maintainer 'ofer987'
maintainer_email 'dan@ofer.to'
license 'All Rights Reserved'
description 'Installs/Configures lamp'
long_description 'Installs/Configures lamp'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'httpd', '~> 0.6'
depends 'mysql', '~> 8.5.1'
depends 'mysql2_chef_gem', '~> 2.1.0'
depends 'database', '~> 6.1.1'


# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/lamp/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/lamp'
