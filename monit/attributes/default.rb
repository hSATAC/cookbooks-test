default[:monit][:notify_emails]         = []

default[:monit][:poll_period]           = 60
default[:monit][:poll_start_delay]      = 120

default[:monit][:mail_format][:subject] = "#{node['name']} $SERVICE $EVENT"
default[:monit][:mail_format][:from]    = "monit@#{node['name']}"
default[:monit][:mail_format][:message]    = <<-EOS
Monit $ACTION $SERVICE at $DATE on #{node['name']}: $DESCRIPTION.
EOS

default[:monit][:mailserver][:host] = "localhost"
default[:monit][:mailserver][:port] = nil
default[:monit][:mailserver][:username] = nil
default[:monit][:mailserver][:password] = nil
default[:monit][:mailserver][:password_suffix] = nil

default[:monit][:web_interface][:enable] = true
default[:monit][:port] = 3737
default[:monit][:private] = true
default[:monit][:address] = "localhost"
default[:monit][:ssl] = false
default[:monit][:cert] = "/etc/monit/monit.pem"
default[:monit][:allow] = ["localhost"]
