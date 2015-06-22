MRuby::Gem::Specification.new('hello_world') do |spec|
  spec.license = 'MIT'
  spec.author  = 'Terence Lee'
  spec.summary = 'Hello World'
  spec.bins    = ['hello_world']
  spec.add_dependency 'mruby-print', :core => 'mruby-print'
end
