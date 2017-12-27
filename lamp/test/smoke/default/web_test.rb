# # encoding: utf-8

# Inspec test for recipe lamp::web

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

if !os.windows?
  describe user('root') do
    it { should exist }
  end
end

describe package 'apache2' do
  it { is_expected.to be_installed }
end

describe service 'apache2-default' do
  it { is_expected.to be_enabled }
  it { is_expected.to be_running }
end

describe command 'wget -qSO- --spider localhost' do
  its('stderr') { is_expected.to match %r{HTTP/1\.1 200 OK} }
end

describe port 80 do
  it { is_expected.to be_listening }
end
