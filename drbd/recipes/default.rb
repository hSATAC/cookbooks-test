package "drbd8-utils"

template "/etc/drbd.d/r1.res" do
  source "r1.res.erb"
end