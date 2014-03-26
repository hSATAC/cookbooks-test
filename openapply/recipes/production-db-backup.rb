
rbenv_gem "backup"

["/home/deployer/Backup", "/home/deployer/Backup/models", "/home/deployer/bin"].each do |dir|
  directory dir do
    owner "deployer"
    group "deployer"
    mode  00755
  end
end

template "/home/deployer/Backup/config.rb" do
  source "backup/config.rb.erb"
  owner  "deployer"
  group  "deployer"
  mode   00644
end

dbs = Chef::EncryptedDataBagItem.load("openapply", "database")["production"]
aws = Chef::EncryptedDataBagItem.load("openapply", "aws-configs")["backup"]

template "/home/deployer/Backup/models/oa_production_db_backup.rb" do
  source "backup/oa_production_db_backup.rb.erb"
  owner  "deployer"
  group  "deployer"
  mode   00644
  variables({
    :access_key_id     => aws["access_key_id"],
    :secret_access_key => aws["secret_access_key"],
    :db_password       => dbs["password"],
    :db_host           => dbs["host"]
  })
end

cron "oa_production_db_backup_cron_job" do
  hour     "5"
  minute   "0"
  user     "deployer"
  command  "/usr/local/rbenv/shims/backup perform -t oa_production_db_backup"
end

template "/home/deployer/bin/db_weekly_backup.sh" do
  source "backup/oa_production_db_weekly.sh.erb"
  owner  "deployer"
  group  "deployer"
  mode   00755
end

cron "oa_production_db_weekly_cron_job" do
  hour     "6"
  minute   "0"
  weekday  "6"
  user     "deployer"
  command  "/home/deployer/bin/db_weekly_backup.sh 2&1> /dev/null"
end
