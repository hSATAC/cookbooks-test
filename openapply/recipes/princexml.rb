#
# Cookbook Name:: princexml
# Recipe:: default
#
# Copyright 2013, Faria Systems Ltd.
#
# All rights reserved - Do Not Redistribute
#

package "libgif4"

remote_file "#{Chef::Config[:file_cache_path]}/prince_9.0-4_ubuntu12.04_amd64.deb" do
  source "http://www.princexml.com/download/prince_9.0-4_ubuntu12.04_amd64.deb"
  backup false
  action :create_if_missing
end

package "prince_9.0-4_ubuntu12.04_amd64.deb" do
  provider Chef::Provider::Package::Dpkg
  source "#{Chef::Config[:file_cache_path]}/prince_9.0-4_ubuntu12.04_amd64.deb"
  action :install
end

cookbook_file "/usr/lib/prince/license/license.dat" do
  source "princexml/license.dat"
  owner "root"
  group "root"
  mode   0644
  action :create
end
