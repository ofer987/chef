#
# Cookbook:: transit.tips
# Recipe:: git
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'git::default'

execute 'start ssh agent' do
  action :run
  user node['nginx']['user']
  command 'eval `ssh-agent`'
end

transit_tips_path = File.join(Dir.home('vagrant'), node['transit.tips']['dir'])
# directory transit_tips_path do
#   recursive true
#   # user node['nginx']['user']
#   # group node['nginx']['group']
# end

# transit.tips
execute 'clone transit.tips' do
  action :run
  user 'vagrant'
  command "git clone #{node['transit.tips']['url']} #{transit_tips_path}"
  not_if "ls #{transit_tips_path}"
end

rsa_ofer987_key_path = File.join(Chef::Config[:file_cache_path], 'rsa_github_ofer987')
cookbook_file rsa_ofer987_key_path do
  action :create
  owner 'vagrant'
  mode '0400'
  source 'rsa_github_ofer987'
end

ssh = File.join(Dir.home('vagrant'), '.ssh')
directory ssh do
  owner 'vagrant'
  action :create
end

known_hosts = File.join(ssh, 'known_hosts')
file known_hosts do
  owner 'vagrant'
  action :create
end

# add github.com as a known host
execute "add github.com to #{known_hosts}" do
  action :run
  user 'vagrant'
  command "echo `ssh-keyscan github.com` >> #{known_hosts}"
end

# create known_hosts file
# ssh_directory = File.join('~root/.ssh')
# directory ssh_directory do
#   owner 'root'
#   action :create
# end

# execute "link #{known_hosts} to ~root/.ssh/known_hosts directory" do
#   action :run
#   user 'root'
#   command "ln -sf #{known_hosts} ~root/.ssh/known_hosts"
# end

# should this be ~nginx? or should this be in ~vagrant?
secrets_path = File.join(Dir.home('vagrant'), node['secrets']['dir'])
execute 'clone secrets' do
  action :run
  user 'vagrant'
  # user node['nginx']['user']
  command "eval `ssh-agent`; ssh-add #{rsa_ofer987_key_path}; git clone #{node['secrets']['url']} #{secrets_path}"
  not_if "ls #{secrets_path}"
end

file rsa_ofer987_key_path do
  action :delete
end
