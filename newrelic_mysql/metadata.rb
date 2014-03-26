name             "newrelic mysql plugin"
maintainer       "mose"
maintainer_email "mose@managebac.com"
license          "Copyright Faria Systems, All rights reserved"
description      "Installs/Configures New Relic Mysql Plugin"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.6"

%w{ debian ubuntu }.each do |os|
  supports os
end

