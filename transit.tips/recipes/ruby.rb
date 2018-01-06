#
# Cookbook:: transit.tips
# Recipe:: ruby
#
# Copyright:: 2017, The Authors, All Rights Reserved.

extend TransitTips::UserHelpers

chef_user = chef

rbenv_system_install 'default' do
  update_rbenv false
end

rbenv_user_install chef_user.name do
  update_rbenv false
end

rbenv_plugin 'ruby-build' do
  git_url 'https://github.com/rbenv/ruby-build.git'
end

rbenv_ruby '2.5.0' do
  user chef_user.name
end

rbenv_global '2.5.0' do
  user chef_user.name
end

rbenv_gem 'bundler' do
  user chef_user.name
  rbenv_version '2.5.0'
end

rbenv_rehash 'default' do
  user chef_user.name
end
