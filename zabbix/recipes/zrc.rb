include_recipe "zabbix::default"
include_recipe "zabbix::ssh_tunnel"
include_recipe "rbenv::default"

package "zabbix-sender"

rbenv_gem "zabbix-ruby-client" do
  ruby_version "1.9.3-p484"
end

directory "/home/deployer/zabbix" do
  group "deployer"
  owner "deployer"
  mode 00755
end

file "/home/deployer/zabbix/.ruby_version" do
  group "deployer"
  owner "deployer"
  mode 00644
  content "1.9.3-p484"
end

execute "init zrc" do
  cwd "/home/deployer/zabbix"
  user "deployer"
  command "sudo rbenv rehash & zrc init ."
  creates "/home/deployer/zabbix/config.yml"
end
