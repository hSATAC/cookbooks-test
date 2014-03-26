
template "#{node['nginx']['dir']}/conf.d/passenger.conf" do
  source 'passenger.conf.nginx.erb'
  mode 0644
  notifies :reload, 'service[nginx]'
end
