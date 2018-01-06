#
# Cookbook:: transit.tips
# Recipe:: client
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# TODO: rename to web_client or something else or put in a module/dir

include_recipe 'nginx::default'

extend TransitTips::UserHelpers

chef_user = chef
nginx_user = nginx

transit_tips_path = File.join(chef_user.home, node['transit.tips']['dir'])
www_transit_tips_path = File.join(nginx_user.home, node['transit.tips']['dir'])

ssl_certificate_path = File.join(chef_user.home, node['secrets']['dir'], 'certificates', 'transit.tips.chained.crt')
ssl_key_path = File.join(chef_user.home, node['secrets']['dir'], 'certificates', 'transit.tips.key')

nginx_site 'client' do
  action :enable
  name 'client'
  template 'client.erb'
  variables(
    client_path: File.join(www_transit_tips_path, 'client'),
    ssl_certificate_path: ssl_certificate_path,
    ssl_certificate_key: ssl_key_path
  )
end

execute 'which erb live stream' do
  action :run
  user chef_user.name
  live_stream true
  command 'echo `which erb`'
end

execute 'install client' do
  action :run
  user chef_user.name
  cwd transit_tips_path
  command "RESTBUS_URL=#{node['transit.tips']['restbus']['public_url']} make install"
end

execute "move clients to nginx's www directory" do
  action :run
  command "cp -R #{transit_tips_path} #{www_transit_tips_path}"
end
