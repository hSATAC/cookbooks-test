# package "openjdk-7-jre-headless"

# group node[:red5][:group] do
#   system true
#   action :create
#   action :create
# end

# user node[:red5][:user] do
#   gid node[:red5][:group]
#   shell "/bin/bash"
#   home node[:red5][:dir]
#   system true
#   action :create
# end

red5_tmp = "#{Chef::Config[:file_cache_path]}/red5.tar.bz2"
remote_file red5_tmp do
  source "http://faria.co/download/red5.tar.bz2"
  not_if "test -h /usr/share/red5"
end

bash "insall red5" do
  cwd node[:red5][:dir]
  code "tar xjvf #{red5_tmp}"
  not_if "test -h /usr/share/red5"
end

service "red5" do
  supports :restart => true
end

link "/usr/share/red5" do
  to "#{node[:red5][:dir]}/red5"
  not_if "test -h /usr/share/red5"
end

directory "/data" do
  mode   "0755"
  not_if "test -d /data"
end


directory "/data/streams" do
  #owner  node[:red5][:user]
  #group  node[:red5][:group]
  mode   "0755"
end

link File.join(node[:red5][:dir],"red5","webapps","videorecorder","streams") do
  to "/data/streams"
end

template "#{node[:red5][:dir]}/red5/conf/red5.properties" do
  source "red5.properties.erb"
  #owner  node[:red5][:user]
  #group  node[:red5][:group]
  mode   "0644"
end

template "/etc/init.d/red5" do
  source "initd-red5"
  owner  "root"
  group  "root"
  mode   "0755"
  notifies :restart, "service[red5]", :immediately
end

execute "update.rc" do
  command "update-rc.d red5 defaults"
end
