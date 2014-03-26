execute "apt-get upgrade" do
  command "apt-get -y upgrade"
  user "root"
end