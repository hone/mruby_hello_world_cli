def gem_config(conf)
  # conf.gembox 'default'
  conf.gem :core => 'mruby-print'

  # be sure to include this gem
  conf.gem File.expand_path(File.dirname(__FILE__))
end

MRuby::Build.new do |conf|
  toolchain :gcc

  conf.bins = ["mrbc"]
  gem_config(conf)
end

MRuby::CrossBuild.new('x86_64-apple-darwin14') do |conf|
  toolchain :gcc

  conf.cc.command       = 'x86_64-apple-darwin14-gcc'
  conf.cxx.command      = 'x86_64-apple-darwin14-g++'
  conf.linker.command   = 'x86_64-apple-darwin14-gcc'
  conf.archiver.command = 'x86_64-apple-darwin14-ar'

  conf.bins = []
  gem_config(conf)
end
