MRuby::Gem::Specification.new('mruby_hello_world') do |spec|
  spec.license = 'MIT'
  spec.author  = 'Terence Lee'
  spec.summary = 'Hello World'

  spec.add_dependency 'mruby-io'
end
