#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2013, Faria Systems Ltd.
#
# All rights reserved - Do Not Redistribute
#

# Install useful or required packages
["git-core", "screen", "vim", "zsh", "tree", "htop", "ntp",
 "curl", "iftop", "iotop",  "psmisc", "iptraf", "sysstat", 
 "wget", "imagemagick", "unzip", "zip",
 "colordiff", "python-software-properties", "libxml2-dev",
 "libxslt-dev", "rdiff-backup", "denyhosts"].each do |pkg|
  package pkg
end

# Install rbenv
include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

# Patch ruby-build download patched ree-1.8.7-2012.02 source code
# http://faria.co/download/ruby-enterprise-1.8.7-2012.02.tar.gz
# Reference: https://coderwall.com/p/nvxecg
ruby_block "patch_ruby_build_use_patched_ree_1.8.7_2012.02" do
  block do
    rc = Chef::Util::FileEdit.new("/usr/local/share/ruby-build/ree-1.8.7-2012.02")
    rc.search_file_replace(
      /http:\/\/rubyenterpriseedition\.googlecode\.com\/files\/ruby-enterprise-1\.8\.7-2012\.02\.tar\.gz#8d086d2fe68a4c57ba76228e97fb3116/,
      "http://faria.co/download/ruby-enterprise-1.8.7-2012.02.tar.gz"
    )
    rc.write_file
  end
end

cookbook_file "/etc/gemrc" do
  source "gemrc"
  owner 'root'
  group 'root'
  mode 00644
end

# Install ruby
node[:rbenv][:install_ruby].each do |ruby|
  rbenv_ruby ruby do
    global true if ruby == node[:rbenv][:global_ruby]
  end
  rbenv_gem "bundler" do
    ruby_version ruby
  end
end

# Install nodejs
include_recipe "nodejs::default"

# Install nessesary gems
gems = %w(chef bundler)
gems.each do |gem|
  rbenv_gem gem
end

# Install extra gems
extra_gems = node[:rbenv][:extra_gems]
extra_gems.each do |gem|
  rbenv_gem      gem[:name] do
    version      gem[:version]
    ruby_version gem[:ruby_version]
  end
end

