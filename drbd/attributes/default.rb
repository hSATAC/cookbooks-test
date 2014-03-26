default[:drbd][:master][:name] = 'mb-production-store'
default[:drbd][:master][:ip]   = '10.0.0.100'
default[:drbd][:master][:port] = '7789'

default[:drbd][:slave][:name] = 'mb-production-store-slave'
default[:drbd][:slave][:ip]   = '10.0.0.101'
default[:drbd][:slave][:port] = '7789'