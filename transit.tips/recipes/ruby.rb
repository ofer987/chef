#
# Cookbook:: transit.tips
# Recipe:: ruby
#
# Copyright:: 2017, The Authors, All Rights Reserved.

rbenv_system_install 'default' do
  update_rbenv false
end

rbenv_user_install 'vagrant' do
  update_rbenv false
end

rbenv_plugin 'ruby-build' do
  git_url 'https://github.com/rbenv/ruby-build.git'
end

rbenv_ruby '2.5.0' do
  user 'vagrant'
end

rbenv_global '2.5.0' do
  user 'vagrant'
end

rbenv_gem 'bundler' do
  user 'vagrant'
  rbenv_version '2.5.0'
end

rbenv_rehash 'default' do
  user 'vagrant'
end
