include_recipe "passenger-enterprise"

["libcurl4-gnutls-dev", "apache2-prefork-dev",
 "libapr1-dev", "libaprutil1-dev"].each do |pkg|
  package pkg
end

mod_passenger_compiled = "/usr/local/rbenv/versions/ree-1.8.7-2012.02/lib/ruby/gems/1.8/gems/passenger-enterprise-server-#{node['apache']['passenger']['version']}/ext/apache2/mod_passenger.so"
execute "/usr/local/rbenv/versions/ree-1.8.7-2012.02/bin/passenger-install-apache2-module --auto" do
  not_if { ::File.exists?(mod_passenger_compiled) }
end

# GC parameters tunning for ree
template "/usr/local/rbenv/versions/ree-1.8.7-2012.02/bin/ruby_wrapper" do
  source 'ruby_wrapper.ree.erb'
  mode 0755
end

template "/etc/apache2/mods-available/passenger.conf" do
  source 'passenger.conf.apache.erb'
  mode 0644
  notifies :restart, 'service[apache2]'
end

template "/etc/apache2/mods-available/passenger.load" do
  source 'passenger.load.apache.erb'
  mode 0644
  notifies :restart, 'service[apache2]'
end

execute  "a2enmod passenger"
