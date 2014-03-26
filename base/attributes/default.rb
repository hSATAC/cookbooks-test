
default[:rbenv][:install_prefix] = "/usr/local"
default[:rbenv][:install_ruby]   = ["1.9.3-p484"]
default[:rbenv][:global_ruby]    =  "1.9.3-p484"

default[:rbenv][:extra_gems] = {}
# extra gems usage sample
# :rbenv => {
#   :extra_gems => [
#     { :name => "backup", :version => "3.0.25", :ruby_version => "1.9.3-p429" },
#     { :name => "json", :version => "1.7.7" },
#     { :name => "mail" }
#   ]
# }
