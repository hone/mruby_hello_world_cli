class HelloWorld
  def initialize(argv)
    @argv
  end

  def run
    if @argv.size > 1
      arguments = @argv[1..-1]
      puts "hello #{arguments.join(" ")}"
    else
      puts "hello world"
    end
  end
end
