require 'coveralls'
Coveralls.wear!

require 'bundler/gem_tasks'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

task :test do
  $LOAD_PATH.unshift('lib', 'tests')
  Dir.glob('./tests/*_test.rb') do |f|
    require f
  end
end
