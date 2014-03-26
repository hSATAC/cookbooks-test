#
# Cookbook Name:: ffmpeg
# Recipe:: default
#
# Copyright 2013, Faria Systems Ltd.
#
# All rights reserved - Do Not Redistribute
#

["autoconf", "build-essential", "checkinstall", "libfaac-dev", "libgpac-dev",
 "libmp3lame-dev", "libopencore-amrnb-dev", "libopencore-amrwb-dev", "libtheora-dev",
 "libtool", "libvorbis-dev", "pkg-config", "texi2html", "yasm", "zlib1g-dev"].each do |pkg|
  package pkg
end

git "#{Chef::Config['file_cache_path']}/ffmpeg" do
  repository "https://github.com/FFmpeg/FFmpeg.git"
  depth 1
  not_if { ::File.exists?("/usr/local/bin/ffmpeg") }
end

bash "compile_ffmpeg" do
  cwd "#{Chef::Config['file_cache_path']}/ffmpeg"
  code <<-EOH
  ./configure --enable-gpl --enable-libmp3lame \
  --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libtheora \
  --enable-libvorbis --enable-nonfree --enable-version3 && make \
  && checkinstall --pkgname=ffmpeg --pkgversion=\"5:$(date +%Y%m%d%H%M)-git\" --backup=no --deldoc=yes --fstrans=no --default \
  && hash ffmpeg
  EOH
  not_if { ::File.exists?("/usr/local/bin/ffmpeg") }
end
