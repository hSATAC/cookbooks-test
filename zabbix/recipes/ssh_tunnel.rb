execute "zabtunnel user" do
  command "sudo useradd -m -r -s /bin/false -d /usr/local/zabtunnel zabtunnel"
  creates "/usr/local/zabtunnel"
end

directory "/usr/local/zabtunnel/.ssh/" do
  owner "zabtunnel"
  group "zabtunnel"
  mode 00700
end

cookbook_file "/usr/local/zabtunnel/.ssh/authorized_keys" do
  source "zabtunnel.pub"
  owner "zabtunnel"
  group "zabtunnel"
  mode 00600
  action :create_if_missing
end

zabtunnel = Chef::EncryptedDataBagItem.load("noc", "zabtunnel")["keys"]

if zabtunnel[node[:name]]

  file "/usr/local/zabtunnel/.ssh/#{zabtunnel[node[:name]]['secret']['file']}" do
    content zabtunnel[node[:name]]['secret']['content']
    owner "zabtunnel"
    group "zabtunnel"
    mode 00600
  end

  file "/usr/local/zabtunnel/.ssh/#{zabtunnel[node[:name]]['public']['file']}" do
    content zabtunnel[node[:name]]['public']['content']
    owner "zabtunnel"
    group "zabtunnel"
    mode 00644
  end

end
