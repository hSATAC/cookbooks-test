#
# Cookbook Name:: fail2ban
# Recipe:: default
#
# Copyright 2013, Faria Systems Ltd.
#
# All rights reserved - Do Not Redistribute
#

package "fail2ban"

template "/etc/fail2ban/jail.conf" do
  source "jail.conf.erb"
  group "root"
  owner "root"
  mode 0666
  notifies :restart, "service[fail2ban]", :delayed
end

template "/etc/fail2ban/action.d/devcore-iptable.conf" do
  source "action.d/devcore-iptable.conf.erb"
  group "root"
  owner "root"
  mode 0666
  notifies :restart, "service[fail2ban]", :delayed
end

template "/etc/fail2ban/filter.d/apache-devcore.conf" do
  source "filter.d/apache-devcore.conf.erb"
  group "root"
  owner "root"
  mode 0666
  notifies :restart, "service[fail2ban]", :delayed
end

service "fail2ban" do
  supports :restart => true
  action :enable
end
