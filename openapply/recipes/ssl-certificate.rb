
directory "#{node[:openapply][:ssl_certificate_path]}" do
  group "root"
  user  "root"
  recursive true
end

cookbook_file "#{node[:openapply][:ssl_certificate_path]}/openapply.com.crt" do
  source "ssl-certificate/openapply.com.crt"
  group "root"
  owner "root"
  mode   0644
  action :create
end

cookbook_file "#{node[:openapply][:ssl_certificate_path]}/openapply.com.key" do
  source "ssl-certificate/openapply.com.key"
  group "root"
  owner "root"
  mode   0644
  action :create
end

cookbook_file "#{node[:openapply][:ssl_certificate_path]}/gd_bundle.crt" do
  source "ssl-certificate/gd_bundle.crt"
  group "root"
  owner "root"
  mode   0644
  action :create
end

cookbook_file "#{node[:openapply][:ssl_certificate_path]}/openapply.com.combined.crt" do
  source "ssl-certificate/openapply.com.combined.crt"
  group "root"
  owner "root"
  mode   0644
  action :create
end
