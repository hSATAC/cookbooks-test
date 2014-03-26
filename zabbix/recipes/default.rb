#
# Cookbook Name:: zabbix
# Recipe:: default
#
# Copyright 2013, Faria Systems
#
# All rights reserved - Do Not Redistribute
#

remote_file "#{Chef::Config[:file_cache_path]}/zabbix-release_2.2-1+precise_all.deb" do
  source "http://repo.zabbix.com/zabbix/2.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_2.2-1+precise_all.deb"
  backup false
  action :create_if_missing
end

package "zabbix-release_2.2-1+precise_all.deb" do
  provider Chef::Provider::Package::Dpkg
  source "#{Chef::Config[:file_cache_path]}/zabbix-release_2.2-1+precise_all.deb"
  action :install
end

execute "apt-get update" do
  user "root"
  command "apt-get update"
end
