node.override["postfix"]["custom_main"] = true
include_recipe "postfix"

template "/etc/postfix/main.cf" do
  source "main.cf.postfix.erb"
  mode 0644
  notifies :restart, "service[postfix]"
end

