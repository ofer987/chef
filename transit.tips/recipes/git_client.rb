#
# Cookbook:: transit.tips
# Recipe:: git_client
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'git::default'

execute 'start ssh agent' do
  action :run
  user node['nginx']['user']
  command 'eval `ssh-agent`'
end

transit_tips_path = File.join("~#{node['nginx']['user']}", node['transit.tips']['dir'])
# directory transit_tips_path do
#   recursive true
#   # user node['nginx']['user']
#   # group node['nginx']['group']
# end

# transit.tips
execute 'clone transit.tips' do
  action :run
  # user node['nginx']['user']
  command "git clone #{node['transit.tips']['url']} #{transit_tips_path}"
end

rsa_ofer987_key_path = File.join(Chef::Config[:file_cache_path], 'rsa_github_ofer987')
cookbook_file rsa_ofer987_key_path do
  action :create
  mode '0400'
  source 'rsa_github_ofer987'
end

# create known_hosts file
directory '.ssh' do
  owner 'root'
  action :create
end

known_hosts = File.join(Chef::Config[:file_cache_path], 'known_hosts')
file known_hosts do
  owner 'root'
  action :create
end

# add github.com as a known host
execute "add github.com to #{known_hosts}" do
  action :run
  user 'root'
  command "echo `ssh-keyscan github.com` >> #{known_hosts}"
end

execute "link #{known_hosts} to ~root/.ssh/known_hosts directory" do
  action :run
  user 'root'
  command "ln -sf #{known_hosts} ~root/.ssh/known_hosts"
end

# should this be ~nginx? or should this be in ~vagrant?
secrets_path = File.join("~#{node['nginx']['user']}", node['secrets']['dir'])
execute 'clone secrets' do
  action :run
  # user node['nginx']['user']
  command "eval `ssh-agent`; ssh-add #{rsa_ofer987_key_path}; git clone #{node['secrets']['url']} #{secrets_path}"
end

file rsa_ofer987_key_path do
  action :delete
end
