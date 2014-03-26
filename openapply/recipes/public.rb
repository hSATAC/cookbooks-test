public_site "openapply" do
  git_repo    "git@github.com:eduvo/openapply_public.git"
  branch      "stable"
  enable      true
  enable_ssl  true
  auto_update false
end

# maintenance page html in openapply_public repo
template "#{node['nginx']['dir']}/sites-available/openapply_maintenance" do
  source "maintenance.nginx.erb"
  group "root"
  owner "root"
  mode 0644
  notifies :reload, 'service[nginx]'
end

nginx_site "openapply_maintenance" do
  enable true
end
