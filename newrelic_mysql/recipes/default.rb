include_recipe 'java7'

nrmp_tmp = File.join(Chef::Config[:file_cache_path],File.basename(node[:newrelic_mysql][:source]))

remote_file nrmp_tmp do
  source node[:newrelic_mysql][:source]
  not_if FileTest.directory? node[:newrelic_mysql][:path]
end

execute "insall Newrelic Mysql plugin" do
  command "tar xzf #{nrmp_tmp} -C #{node[:newrelic_mysql][:path]}"
end

template "#{node[:newrelic_mysql][:path]}/config/logging.properties" do
  source "logging.properties"
end

template "#{node[:newrelic_mysql][:path]}/config/mysql.instance.json" do
  source "mysql.instance.json.erb"
end

template "#{node[:newrelic_mysql][:path]}/config/newrelic.properties" do
  source "newrelic.properties.erb"
end

execute "create/update newrelic users" do
  node[:newrelic_mysql][:newrelic].each_with_index do |host,i|
    command "mysql 
      -h#{node[:newrelic_mysql][:mysql][i][:host]} 
      -u#{node[:newrelic_mysql][:mysql][i][:user]} 
      -p#{node[:newrelic_mysql][:mysql][i][:password]} 
      -e 'CREATE USER #{host[:user]}@#{host[:host]} IDENTIFIED BY \'#{host[:passwd]}\';
          GRANT PROCESS,REPLICATION CLIENT ON *.* TO #{host[:user]}@#{host[:host]};
      '"
  end
end

template "/etc/init.d/newrelic-mysql-plugin" do
  source "initd_newrelic-mysql-plugin.erb"
  notifies :restart, "service[newrelic-mysql-plugin]", :delayed    
end

service "newrelic-mysql-plugin" do
  service_name "newrelic-mysql-plugin"
  if node[:newrelic_mysql][:use_upstart]
    provider Chef::Provider::Service::Upstart
  end
  supports :status => true, :restart => true, :reload => false
  action :enable
end
