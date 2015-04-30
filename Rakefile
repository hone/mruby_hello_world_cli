APP_ROOT=ENV["APP_ROOT"] || Dir.pwd
APP_BINARY=ENV["APP_BINARY"] || "hello_world"
MRUBY_ROOT=ENV["MRUBY_ROOT"] || "#{APP_ROOT}/mruby"
MRUBY_CONFIG=File.expand_path(ENV["MRUBY_CONFIG"] || "build_config.rb")
INSTALL_PREFIX=ENV["INSTALL_PREFIX"] || "#{APP_ROOT}/build"
MRUBY_VERSION=ENV["MRUBY_VERSION"] || "1.1.0"

file :mruby do
  sh "wget --no-check-certificate -O mruby.tar.gz https://github.com/mruby/mruby/archive/#{MRUBY_VERSION}.tar.gz"
  sh "tar -xvzf mruby.tar.gz"
  sh "rm mruby.tar.gz"
  sh "mv mruby-#{MRUBY_VERSION} #{MRUBY_ROOT}"
end

desc "compile binary"
task :compile => :mruby do
  sh "cd #{MRUBY_ROOT} && MRUBY_CONFIG=#{MRUBY_CONFIG} rake all"
  sh "mkdir -p #{APP_ROOT}/bin"
  sh "gcc -Iinclude #{APP_ROOT}/src/#{APP_BINARY}.c -I#{MRUBY_ROOT}/include/ #{MRUBY_ROOT}/build/host/lib/libmruby.a -lm -o #{APP_ROOT}/bin/#{APP_BINARY}"
end

desc "test"
task :test => :mruby do
  sh "cd #{MRUBY_ROOT} && MRUBY_CONFIG=#{MRUBY_CONFIG} rake all test"
end

desc "install"
task :install => :compile do
  sh "mkdir -p #{INSTALL_PREFIX}/bin"
  sh "cp -p #{APP_ROOT}/bin/#{APP_BINARY} #{INSTALL_PREFIX}/bin/."
end

desc "cleanup"
task :clean do
  sh "rm #{APP_ROOT}/bin/#{APP_BINARY}"
  sh "cd #{MRUBY_ROOT} && rake deep_clean"
end

task :default => :test
