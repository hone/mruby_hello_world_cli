MRuby::Build.new do |conf|
  # Gets set by the VS command prompts.
  if ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    toolchain :visualcpp
  else
    toolchain :gcc
  end

  # conf.gembox 'default'
  conf.gem :core => 'mruby-print'

  # be sure to include this gem
  # conf.gem File.expand_path(File.dirname(__FILE__))
end
