include_recipe "java7"
include_recipe "elasticsearch::deb"
include_recipe "nginx"

service "elasticsearch" do
  supports :status => true, :restart => true, :reload => true
  action :enable
end

template "/etc/default/elasticsearch" do
  source "elasticsearch.default.erb"
  owner "root" and group "root" and mode 00644
end

template "/etc/elasticsearch/elasticsearch.yml" do
  source "elasticsearch.yml.erb"
  owner "root" and group "root" and mode 00644
  notifies :restart, 'service[elasticsearch]'
end

template "/etc/elasticsearch/logging.yml" do
  source "elasticsearch.logging.yml.erb"
  owner "root" and group "root" and mode 00644
  notifies :restart, 'service[elasticsearch]'
end

cookbook_file "/etc/nginx/htpass-eduvo" do
  source "htpass-eduvo"
  owner "root" and group "root" and mode 00644
end

git "/srv/elastic-hq" do
  repository "https://github.com/royrusso/elasticsearch-HQ.git"
  depth 1
  not_if { ::File.exists?("/srv/elastic-hq/index.html") }
end

template "/etc/nginx/sites-available/elasticsearch" do
  source "elasticsearch.nginx.erb"
  owner "root" and group "root" and mode 00644
  notifies :restart, 'service[nginx]'
end

nginx_site "elasticsearch" do
  enable true
end
