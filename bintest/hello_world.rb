require 'open3'

BIN_PATH = File.join(File.dirname(__FILE__), "../bin/hello_world")

assert('no arguments') do
  o, s = Open3.capture2(BIN_PATH)
  assert_true o.include?('hello world')
end

assert('arguments') do
  o, s = Open3.capture2("#{BIN_PATH} Godfrey Chan")
  assert_true o.include?('hello Godfrey Chan')
end
