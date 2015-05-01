if ARGV.size > 1
  arguments = ARGV[1..-1]
  puts "hello #{arguments.join(" ")}"
else
  puts "hello world"
end
