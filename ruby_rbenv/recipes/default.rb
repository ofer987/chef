# frozen_string_literal: true

# TODO: try without system
VERSION = '2.4.1'
USER = 'vagrant'
# TODO: add www-data user

# Install rbenv
rbenv_user_install USER do
  user USER
end

# Install ruby
rbenv_ruby VERSION do
  user USER
end

# Set VERSION to global (default?)
rbenv_global VERSION do
  user USER
end

rbenv_gem 'bundler' do
  rbenv_version VERSION
  user USER
end
