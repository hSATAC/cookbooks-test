include_recipe "openapply::princexml"
include_recipe "projects::fonts"
include_recipe "openapply::ssl-certificate"

project_name = "openapply"
project_env  = node['openapply']['environment']

# create directories
directory "/srv/#{project_name}" do
  owner "deployer"
  group "deployer"
  mode  0775
end

["releases", "shared", "shared/config", "shared/system", "shared/log",
 "shared/pids"].each do |dir|
  directory "/srv/#{project_name}/#{dir}" do
    owner "deployer"
    group "deployer"
    mode  0775
  end
end

directory "#{node['nginx']['log_dir']}/#{project_name}" do
  owner "root"
  group "root"
  mode 0755
end

# generate and enable nginx config
subdomain = case project_env
  when "production" then "faria"
  when "staging"    then "dev"
  when "sandbox"    then "demo"
end

template "#{node['nginx']['dir']}/sites-available/#{project_name}" do
  source "rails.nginx.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :reload, 'service[nginx]'
end

nginx_site project_name do
  enable true
end

template "/etc/logrotate.d/rails" do
  source "rails.logrotate.erb"
  mode 0644
end

# generate config files
database = Chef::EncryptedDataBagItem.load("openapply", "database")[project_env]

template "/srv/#{project_name}/shared/config/database.yml" do
  source "database.yml.erb"
  owner  "deployer"
  group  "deployer"
  mode   0644
  variables({
    :password => database["password"],
    :host     => database["host"]
  })
end

amqp = Chef::EncryptedDataBagItem.load("openapply", "amqp")[project_env]

template "/srv/#{project_name}/shared/config/amqp.yml" do
  source "amqp.yml.erb"
  owner  "deployer"
  group  "deployer"
  mode   00644
  variables({
    :username => amqp["username"],
    :password => amqp["password"],
    :host     => amqp["host"],
    :vhost    => amqp["vhost"]
  })
end

template "/srv/#{project_name}/shared/config/faria_mq.yml" do
  source "faria_mq.yml.erb"
  owner  "deployer"
  group  "deployer"
  mode   00644
  variables({
    :username => amqp["username"],
    :password => amqp["password"],
    :host     => amqp["host"],
    :vhost    => amqp["vhost"]
  })
end


dotenv = Chef::EncryptedDataBagItem.load("openapply", "dotenv")[project_env]

template "/srv/#{project_name}/shared/config/env.#{project_env}" do
  source "dotenv.erb"
  owner  "deployer"
  group  "deployer"
  mode   0644
  variables({
    :secret_token => dotenv["secret_token"],
  })
end

if project_env == 'production'
  aws = Chef::EncryptedDataBagItem.load("openapply", "aws-configs")[project_env]

  template "/srv/#{project_name}/shared/config/aws.yml" do
    source "aws.yml.erb"
    owner  "deployer"
    group  "deployer"
    mode   0644
    variables({
      :access_key_id      => aws["access_key_id"],
      :secret_access_key  => aws["secret_access_key"],
      :bucket_name        => aws["bucket_name"],
      :uploads_asset_host => aws["uploads_asset_host"]
    })
  end
end

# rubygem charlock_holmes required package
package "libicu-dev"
