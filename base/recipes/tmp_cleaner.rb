template '/etc/cron.d/clean_tmp' do 
  source 'clean_tmp.cron'
  owner 'root'
  group 'root'
  mode '0644'
end