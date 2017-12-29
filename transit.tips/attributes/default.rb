# (node['nginx']['source']['modules'] ||= []) << 'nginx::http_v2_module'

default['transit.tips']['url'] = 'https://github.com/ofer987/transit.tips.git'
default['transit.tips']['dir'] = 'transit.tips'

default['secrets']['url'] = 'git@github.com:ofer987/secrets.git'
default['secrets']['dir'] = 'secrets'
