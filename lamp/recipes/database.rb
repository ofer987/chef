#
# Cookbook:: lamp
# Recipe:: database
#
# Copyright:: 2017, The Authors, All Rights Reserved.

passwords = data_bag_item('passwords', 'mysql')
dbname = node['lamp']['database']['dbname']
db_addr = '127.0.0.1'
mysql_connection_info = {
  host: db_addr,
  username: 'root',
  password: passwords['root_password']
}

mysql_client 'default' do
  action :create
end

mysql_service 'default' do
  port '3306'
  version '5.7'
  initial_root_password passwords['root_password']
  action %i[create start]
end

mysql2_chef_gem 'default' do
  action :install
end

# create the database instance
mysql_database dbname do
  connection mysql_connection_info
  action :create
end

# create the database admin user
mysql_database_user node['lamp']['database']['admin_username'] do
  connection mysql_connection_info
  host db_addr
  password passwords['admin_password']
  database_name dbname
  action %i[create grant]

end
