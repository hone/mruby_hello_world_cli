APP_ROOT=ENV["APP_ROOT"] || Dir.pwd
APP_NAME=ENV["APP_NAME"] || "hello_world"
APP_BIN_FILE="#{APP_ROOT}/bin/#{APP_NAME}"
MRUBY_ROOT=ENV["MRUBY_ROOT"] || "#{APP_ROOT}/mruby"
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

file MRBC_FILE => [:mruby, "#{APP_ROOT}/src/#{APP_NAME}.c", "#{APP_ROOT}/mrblib/#{APP_NAME}.rb"] do
  sh "cd #{MRUBY_ROOT} && MRUBY_CONFIG=#{MRUBY_CONFIG} rake all"
  sh "mkdir -p #{APP_ROOT}/tmp"
  sh "#{MRUBY_ROOT}/build/host/bin/mrbc -Bhello_world -o#{MRBC_FILE} #{APP_ROOT}/mrblib/#{APP_NAME}.rb"
end

file APP_BIN_FILE => MRBC_FILE do
  src_contents = File.read("#{APP_ROOT}/src/#{APP_NAME}.c")
  tmp_contents = File.read(MRBC_FILE)
  tmp_src_file = "#{TMP_DIR}/#{APP_NAME}.c"
  File.open(tmp_src_file, 'w') do |file|
    file.puts(tmp_contents)
    file.puts(src_contents)
  end
  sh "mkdir -p #{APP_ROOT}/bin"
  sh "gcc -Iinclude #{tmp_src_file} -I#{MRUBY_ROOT}/include/ #{MRUBY_ROOT}/build/host/lib/libmruby.a -lm -o #{APP_BIN_FILE}"
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
