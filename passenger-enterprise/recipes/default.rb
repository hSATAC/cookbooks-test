
if node['nginx'] && node['nginx']['passenger']
  passenger_version = node['nginx']['passenger']['version']
  ruby_version = node['nginx']['passenger']['ruby_version'] || node['rbenv']['global_ruby']
elsif node['apache'] && node['apache']['passenger']
  passenger_version = node['apache']['passenger']['version']
  ruby_version = node['apache']['passenger']['ruby_version'] || node['rbenv']['global_ruby']
else
  raise "Please specify passenger version in nginx or apache attributes."
end

cookbook_file "#{Chef::Config[:file_cache_path]}/passenger-enterprise-server-#{passenger_version}.gem" do
  mode 0644
  action :create_if_missing
end

gem_package 'passenger-enterprise-server' do
  #rbenv_version "#{ruby_version}"
  gem_binary "/usr/local/rbenv/versions/#{ruby_version}/bin/gem"
  source "#{Chef::Config[:file_cache_path]}/passenger-enterprise-server-#{passenger_version}.gem"
  version passenger_version
  action :install
end

cookbook_file '/etc/passenger-enterprise-license' do
  mode 0644
  action :create_if_missing
end
