#
# Cookbook:: transit.tips
# Recipe:: client
#
# Copyright:: 2017, The Authors, All Rights Reserved.

client_path = '/http/transit.tips/client'
directory client_path do
  recursive true
  user node['nginx']['user']
  group node['nginx']['group']
end

ssl_certificate_path = File.join("~#{node['nginx']['user']}", node['secrets']['path'], 'certificates', 'transit.tips.chained.crt')
ssl_key_path = File.join("~#{node['nginx']['user']}", node['secrets']['path'], 'certificates', 'transit.tips.key')

nginx_site 'client' do
  action :enable
  name 'client'
  template 'client.erb'
  variables(
    client_path: client_path,
    ssl_certificate: ssl_certificate_path,
    ssl_certificate_key: ssl_key_path
  )
end
