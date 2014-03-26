#
# Cookbook Name:: mod-evasive
# Recipe:: default
#
# Copyright 2013, Faria Systems Ltd.
#
# All rights reserved - Do Not Redistribute
#

package "libapache2-mod-evasive"

template "/etc/apache2/mods-available/mod-evasive.conf" do
  source "mod-evasive.conf.erb"
  group "root"
  owner "root"
  mode 0644
end

directory "/var/log/mod_evasive" do
  group "www-data"
  owner "www-data"
  mode 0755
end

bash "enable_mod_evasive_module" do
  group "root"
  user  "root"
  code <<-EOH
  a2enmod mod-evasive
  EOH
end
