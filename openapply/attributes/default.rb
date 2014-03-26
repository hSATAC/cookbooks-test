default[:openapply][:environment] = "development"
default[:openapply][:ssl_certificate_path] = "/opt/ssl-certificate/openapply"

default[:elasticsearch][:cluster_name] = "faria"
default[:elasticsearch][:node_name] = "oa-es"
default[:elasticsearch][:deb_url] = "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.5.deb"
default[:elasticsearch][:deb_sha] = "d25cdc971b1ef2393a620731137bae16e0d1107d49294b11c14634da0f1bb330"
default[:elasticsearch][:heap_size] = "2g"
default[:elasticsearch][:direct_size] = "256m"
default[:elasticsearch][:gc_settings] =<<-CONFIG
  -XX:+UseParNewGC
  -XX:+UseConcMarkSweepGC
  -XX:CMSInitiatingOccupancyFraction=75
  -XX:+UseCMSInitiatingOccupancyOnly
  -XX:+HeapDumpOnOutOfMemoryError
CONFIG
allocated_memory = "#{(node.memory.total.to_i * 0.6 ).floor / 1024}m"
default[:elasticsearch][:allocated_memory] = allocated_memory
default[:elasticsearch][:thread_stack_size] = "256k"

default[:logrotate][:keep] = 730
