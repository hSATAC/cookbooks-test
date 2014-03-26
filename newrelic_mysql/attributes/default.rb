default[:newrelic_mysql][:license]     = "a9303e677a260eb8c28c8d0b4338eb53e1a60578"
default[:newrelic_mysql][:source]      = "http://faria.co/download/newrelic_mysql_plugin-1.0.6.tar.gz"
default[:newrelic_mysql][:path]        = "/usr/local/src/newrelic_mysql_plugin-1.0.6"
default[:newrelic_mysql][:use_upstart] = false
default[:newrelic_mysql][:create_user] = false

default[:newrelic_mysql][:mysql] = []
default[:newrelic_mysql][:mysql] << { 
  user: 'root', 
  password: '', 
  host: 'localhost' 
}

default[:newrelic_mysql][:newrelic] = []
default[:newrelic_mysql][:newrelic] << { 
  name: 'db', 
  host: 'localhost', 
  user: 'newrelic', 
  passwd: "zepass4newrelic!", 
  metrics: "status,newrelic" 
}