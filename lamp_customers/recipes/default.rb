#
# Cookbook:: lamp_customers
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'lamp::default'

passwords = data_bag_item('passwords', 'mysql')

create_tables_script_path = File.join(Chef::Config[:file_cache_path], 'create-tables.sql')

# write the SQL script to the filesystem
cookbook_file create_tables_script_path do
  source 'create-tables.sql'
end

# seed the database
db_name = node['lamp']['database']['dbname']
db_username = node['lamp']['database']['admin_username']
db_password = passwords['admin_password']

execute "initialise #{db_name} database" do
  command "mysql -h 127.0.0.1 -u #{db_username} -p#{db_password} -D #{db_name} < #{create_tables_script_path}"

  not_if "mysql -h 127.0.0.1 -u #{db_username} -p#{db_password} -D #{db_name} -e 'describe customers;'"
end

# write the homepage
index_php_path = File.join(node['lamp']['web']['document_root'], 'index.php')
template index_php_path do
  source 'index.php.erb'
  variables(
    servername: '127.0.0.1',
    admin_password: db_password
  )
end
