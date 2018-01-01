#
# Cookbook:: transit.tips
# Recipe:: chef_user
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# rename to chef
user 'vagrant' do
  home '/home/vagrant'
  shell '/bin/bash'
  # change to :create
  action :modify
end

user node['nginx']['user'] do
  home '/var/www'
  shell '/bin/bash'
  action :modify
end

directory '/var/www' do
  recursive true
  mode 0755
  owner 'root'
  group 'root'

  action :create
end
