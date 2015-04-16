require 'rubygems'
require 'bundler/setup'
require "erb"
Bundler.require(:default)

ActiveRecord::Base.logger = Logger.new(STDERR)

database_path = File.expand_path("../database.yml", __FILE__)
database_config = YAML.load_file(ERB.new(database_path).result)

ENV["RACK_ENV"] ||= "development"
ActiveRecord::Base.establish_connection(database_config[ENV["RACK_ENV"]])

# Order is important - helpers should go first
%w(helpers api serializers models).each do |dir|
  Dir[File.join(".", "lib/#{dir}/**/*.rb")].each {|_file| require _file}
end