MRuby::Build.new do |conf|
  # Gets set by the VS command prompts.
  if ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    toolchain :visualcpp
  else
    toolchain :gcc
  end

  enable_debug

  conf.gembox 'default'

  conf.gem :github => 'iij/mruby-io'

  # be sure to include this gem
  conf.gem File.expand_path(File.dirname(__FILE__))
end
