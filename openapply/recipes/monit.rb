include_recipe "monit"

project_env = node['openapply']['environment']

monitrc "redis6379" do
  template_cookbook "openapply"
  template_source   "redis6379.monit.erb"
  variables({
    :environment => project_env
  })
end

monitrc "memcached" do
  template_cookbook "openapply"
  template_source   "memcached.monit.erb"
  variables({
    :environment => project_env
  })
end


monitrc "faria_mq_oa" do
  template_cookbook "openapply"
  template_source   "faria_mq.monit.erb"
  variables({
    :pid_file => 'faria_mq_oa.pid',
    :exec_name => "faria_mq",
    :ruby_version => node['openapply']['ruby_version'],
    :environment => project_env
  })
end

if project_env == "production" || project_env == "staging"
  case project_env
  when "production"
    pid_file = "delayed_job.0.pid"
    workers  = 2
  when "staging"
    pid_file = "delayed_job.pid"
    workers  = 1
  end

  monitrc "delayed_job" do
    template_cookbook "openapply"
    template_source   "delayed_job.monit.erb"
    variables({
      :workers  => workers,
      :pid_file => pid_file,
      :environment => project_env
    })
  end

  template "/usr/local/bin/check_delayed_jobs.sh" do
    source "check_delayed_jobs.sh.erb"
    owner "root" and group "root" and mode 00755
    variables({
      :workers  => workers
    })
  end

end
