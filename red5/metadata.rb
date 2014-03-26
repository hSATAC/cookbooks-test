project_root = File.expand_path("..", __FILE__)
version_file = File.join(project_root, "VERSION")


maintainer        "mose"
maintainer_email  "mose@managebac.com"
license           "All rights reserved Copyright Faria Systems"
description       "Installs Red5"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           File.open(version_file) { |f| f.read }

recipe "red5", "Installs Red5"

supports "ubuntu"
