#
# Cookbook:: transit.tips
# Recipe:: client
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# TODO: rename to web

include_recipe 'nginx::default'

transit_tips_path = File.join("~#{node['nginx']['user']}", node['transit.tips']['dir'])

ssl_certificate_path = File.join("~#{node['nginx']['user']}", node['secrets']['dir'], 'certificates', 'transit.tips.chained.crt')
ssl_key_path = File.join("~#{node['nginx']['user']}", node['secrets']['dir'], 'certificates', 'transit.tips.key')

nginx_site 'client' do
  action :enable
  name 'client'
  template 'client.erb'
  variables(
    client_path: File.join(transit_tips_path, 'client'),
    ssl_certificate: ssl_certificate_path,
    ssl_certificate_key: ssl_key_path
  )
end
