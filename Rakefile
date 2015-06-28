APP_ROOT=ENV["APP_ROOT"] || Dir.pwd
APP_NAME=ENV["APP_NAME"] || "hello_world"
APP_BIN_FILE="#{APP_ROOT}/bin/#{APP_NAME}"
MRUBY_ROOT=ENV["MRUBY_ROOT"] || "#{APP_ROOT}/mruby"
MRUBY_CONFIG=File.expand_path(ENV["MRUBY_CONFIG"] || "build_config.rb")
INSTALL_PREFIX=ENV["INSTALL_PREFIX"] || "#{APP_ROOT}/build"
MRUBY_VERSION=ENV["MRUBY_VERSION"] || "1.1.0"

def uid
  @uid ||= `id -u`.chomp
end

def gid
  @gid ||= `id -g`.chomp
end

file "Dockerfile" do
  File.open('Dockerfile', 'w') do |file|
    file.puts <<DOCKERFILE
FROM hone/mruby-cli

# setup user account based off host uid/gid
RUN groupadd -g #{gid} -r mruby && useradd -u #{uid} -l -g mruby mruby
USER mruby
DOCKERFILE
  end
end

file 'docker-compose.yml' do
  File.open('docker-compose.yml', 'w') do |file|
    file.puts <<DOCKER_COMPOSE_YML
compile: &defaults
  build: .
  volumes:
    - .:/home/mruby/code:rw
  command: rake compile
  user: #{uid}
clean:
  <<: *defaults
  command: rake clean
shell:
  <<: *defaults
  command: bash
DOCKER_COMPOSE_YML
  end
end

desc "Setup Docker for building things locally"
task :setup => ["Dockerfile", "docker-compose.yml"] do
  sh "docker-compose build"
end

file :mruby do
  sh "git clone https://github.com/mruby/mruby"
end

desc "compile binary"
task :compile => :mruby do
  sh "cd #{MRUBY_ROOT} && MRUBY_CONFIG=#{MRUBY_CONFIG} rake all"
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
  sh "cp -p #{MRUBY_ROOT}/bin/#{APP_NAME} #{INSTALL_PREFIX}/bin/."
end

desc "cleanup"
task :clean do
  sh "cd #{MRUBY_ROOT} && rake deep_clean"
end

task :default => :test
