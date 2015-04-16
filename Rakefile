require './config/application.rb'

task :console do
  require 'irb'
  require 'irb/completion'
  ARGV.clear
  IRB.start
end

# require all rake tasks from the lib/tasks dir
Dir.glob('./lib/tasks/*.rake').each { |r| import r }

task default: [:test]

task :test do
  puts "there will be tests"
end