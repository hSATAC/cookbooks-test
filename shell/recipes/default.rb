#
# Cookbook Name:: shell
# Recipe:: default
#

include_recipe "git"

package "bash-completion"
package "zsh"

template "/etc/profile.d/faria-shell.sh" do
  source "faria-shell.sh.erb"
  owner  "root"
  group  "root"
  mode   "0644"
end

template "/etc/skel/.bashrc" do
  source "bashrc"
  owner "root"
  group "root"
  mode "0644"
end


template "/etc/bash.bashrc" do
  source "etc-bash.bashrc.erb"
  owner "root"
  group "root"
  mode "0644"
end
