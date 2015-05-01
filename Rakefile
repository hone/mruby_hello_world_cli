APP_ROOT=ENV["APP_ROOT"] || Dir.pwd
APP_NAME=ENV["APP_NAME"] || "hello_world"
APP_BIN_FILE="#{APP_ROOT}/bin/#{APP_NAME}"
MRUBY_ROOT=ENV["MRUBY_ROOT"] || "#{APP_ROOT}/mruby"
MRUBY_FILES=Dir.glob("#{APP_ROOT}/mrblib/*")
MRUBY_CONFIG=File.expand_path(ENV["MRUBY_CONFIG"] || "build_config.rb")
TMP_DIR=ENV["APP_TMP_DIR"] || "#{APP_ROOT}/tmp"
MRBC_FILE="#{TMP_DIR}/mrbc.c"
INSTALL_PREFIX=ENV["INSTALL_PREFIX"] || "#{APP_ROOT}/build"
MRUBY_VERSION=ENV["MRUBY_VERSION"] || "1.1.0"

file :mruby do
  sh "wget --no-check-certificate -O mruby.tar.gz https://github.com/mruby/mruby/archive/#{MRUBY_VERSION}.tar.gz"
  sh "tar -xvzf mruby.tar.gz"
  sh "rm mruby.tar.gz"
  sh "mv mruby-#{MRUBY_VERSION} #{MRUBY_ROOT}"
end

desc "compile binary"
task :compile => APP_BIN_FILE

file APP_BIN_FILE do
  sh "mkdir -p #{APP_ROOT}/bin"
  sh "gcc -Iinclude #{APP_ROOT}/tools/wrapper.c -I#{MRUBY_ROOT}/include/ #{MRUBY_ROOT}/build/host/lib/libmruby.a -lm -o #{APP_BIN_FILE}"
end

namespace :test do
  desc "run mruby tests"
  task :mrbtest => :mruby do
    sh "cd #{MRUBY_ROOT} && MRUBY_CONFIG=#{MRUBY_CONFIG} rake all test"
  end

  desc "run app tests"
  task :app => :compile do
    sh "cd #{MRUBY_ROOT} && ruby #{MRUBY_ROOT}/test/bintest.rb #{APP_ROOT}"
  end
end

desc "run all tests"
task :test => ["test:mrbtest", "test:app"]

desc "install"
task :install => :compile do
  sh "mkdir -p #{INSTALL_PREFIX}/bin"
  sh "cp -p #{APP_ROOT}/bin/#{APP_NAME} #{INSTALL_PREFIX}/bin/."
end

desc "cleanup"
task :clean do
  sh "rm #{APP_ROOT}/bin/#{APP_NAME}"
  sh "rm #{TMP_DIR}/*"
  sh "cd #{MRUBY_ROOT} && rake deep_clean"
end

task :default => :test
