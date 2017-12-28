#
# Cookbook:: lamp
# Recipe:: web
#
# Copyright:: 2017, The Authors, All Rights Reserved.

group 'web_admin'
user 'web_admin' do
  action :create
  gid 'web_admin'
  shell '/bin/bash'
  home '/home/web_admin'
end

directory node['lamp']['web']['document_root'] do
  user 'web_admin'
  group 'web_admin'
  recursive true
end

httpd_config 'default' do
  source 'default.conf.erb'
  instance 'default'
end

httpd_service 'default' do
  instance 'default'
  mpm 'prefork'
  action [:create, :start]
  run_user 'web_admin'
  run_group 'web_admin'
  subscribes :restart, 'httpd_config[default]'
end

# php7
httpd_module 'php7' do
  instance 'default'
  package_name 'libapache2-mod-php'
  filename 'libphp7.0.so'
end

# php7 for mysql
package 'php-mysql' do
  action :install
  notifies :restart, 'httpd_service[default]'
end

template "#{node['lamp']['web']['document_root']}/index.php" do
  source 'index.php.erb'
  variables(
    message: 'from the outside'
  )
end
