# # encoding: utf-8

# Inspec test for recipe transit.tips::git_client

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe git_client 'is installed', :skip do
  it { should be_installed }
end

describe git_client 'version', :skip do
  its(:version) { should eq('2.9.5') }
end

describe command "Dir.exist? #{node['transit.tips']['path']}", :skip do
  it { should_exist }
end

describe command "Dir.exist? #{node['secrets']['path']}", :skip do
  it { should_exist }
end
