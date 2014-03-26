#
# Cookbook Name:: php-fastcgi
# Recipe:: default
#
# Copyright 2013, Faria Systems Ltd.
#
# All rights reserved - Do Not Redistribute
#
# Reference:
# http://library.linode.com/lemp-guides/ubuntu-12.04-precise-pangolin#sph_deploy-php-with-fastcgi
#

# Install the required dependencies
["php5-cli", "php5-cgi", "php5-mysql", "psmisc", "spawn-fcgi"].each do |pkg|
  package pkg
end

template "/usr/bin/php-fastcgi" do
  source "bin-php-fastcgi.erb"
  mode 0755
  action :create
end

template "/etc/init.d/php-fastcgi" do
  source "init-php-fastcgi.erb"
  mode 0755
  action :create
end

bash "start_php_fastcgi" do
  code <<-EOH
  /etc/init.d/php-fastcgi restart
  update-rc.d php-fastcgi defaults
  EOH
end
