#
# Cookbook:: transit.tips
# Recipe:: git_client
#
# Copyright:: 2017, The Authors, All Rights Reserved.

git_client 'default' do
  action :install
end

execute 'clone transit.tips' do
  command "git clone #{default['transit.tips']['url']} #{default['transit.tips']['path']}"
end

secrets_path = File.join('~', default['secrets']['path'])
execute 'clone secrets' do
  action :run
  user node['nginx']['user']
  command "git clone #{default['secrets']['url']} #{secrets_path}"
end
