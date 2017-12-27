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
end

httpd_service 'default' do
  mpm 'prefork'
  action [:create, :start]
  subscribes :restart, 'httpd_config[default]'
end
