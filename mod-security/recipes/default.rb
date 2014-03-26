#
# Cookbook Name:: mod-security
# Recipe:: default
#
# Copyright 2013, Faria Systems Ltd.
#
# All rights reserved - Do Not Redistribute
#
# Referenced from this link
# http://www.thefanclub.co.za/how-to/how-install-apache2-modsecurity-and-modevasive-ubuntu-1204-lts-server
#

['libxml2', 'libxml2-dev', 'libxml2-utils', 'libaprutil1',
 'libaprutil1-dev'].each do |pkg|
  package pkg
end

link "/usr/lib/libxml2.so.2" do
  to "/usr/lib/x86_64-linux-gnu/libxml2.so.2"
end

package 'libapache-mod-security'

template "/etc/modsecurity/modsecurity.conf" do
  source "modsecurity.conf.erb"
  group "root"
  owner "root"
  mode 0644
end

bash "enable_mod_security_module" do
  group "root"
  user  "root"
  code <<-EOH
  a2enmod headers
  a2enmod mod-security
  EOH
end
