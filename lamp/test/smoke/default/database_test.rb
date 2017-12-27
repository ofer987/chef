# # encoding: utf-8

# Inspec test for recipe lamp::database

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

if !os.windows?
  # This is an example test, replace with your own test.
  describe user('root') do
    it { is_expected.to exist }
  end
end

# This is an example test, replace it with your own test.
describe port(80) do
  it { should_not be_listening }
end

describe mysql_conf('/etc/mysql-default/my.cnf').params('mysqld') do
  its(:port) { is_expected.to eq '3306'}
  its(:socket) { is_expected.to eq '/run/mysql-default/mysqld.sock'}
end

describe port(3306) do
  it { is_expected.to be_listening }
  its(:protocols) { is_expected.to include(:tcp) }
end

# learn about mysql cli command
describe command("mysql -h 127.0.0.1 -uroot -preplacewith_real_apssword -s -e 'show databases;'"), :skip do
  its(:stdout) { is_expected.to match(/mysql/) }
end
