require 'yaml'
require 'logger'
require 'active_record'
require 'active_support/core_ext/string/strip'
require "erb"

namespace :db do
  task :environment do
    DATABASE_ENV = ENV['RACK_ENV'] || 'development'
    MIGRATIONS_DIR = ENV['MIGRATIONS_DIR'] || 'db/migrate'
  end

  task :connection => :environment do
    @config = YAML.load(ERB.new('./config/database.yml').result)[DATABASE_ENV]
    ActiveRecord::Base.establish_connection @config
    ActiveRecord::Base.logger = Logger.new STDOUT
  end

  desc 'Migrate the database (options: VERSION=x, VERBOSE=false).'
  task :migrate => :connection do
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate MIGRATIONS_DIR, ENV['VERSION'] ? ENV['VERSION'].to_i : nil
  end

  desc 'Rolls the schema back to the previous version (specify steps w/ STEP=n).'
  task :rollback => :connection do
    step = ENV['STEP'] ? ENV['STEP'].to_i : 1
    ActiveRecord::Migrator.rollback MIGRATIONS_DIR, step
  end

  desc "Retrieves the current schema version number"
  task :version => :connection do
    puts "Current version: #{ActiveRecord::Migrator.current_version}"
  end

  desc "Create a template for the migration"
  task :migration do
    name = ENV['NAME'] || raise("Specify name: rake g:migration NAME=create_users")
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")

    path = File.expand_path("../../../db/migrate/#{timestamp}_#{name}.rb", __FILE__)
    migration_class = name.split("_").map(&:capitalize).join

    File.open(path, 'w') do |file|
      file.write <<-EOF.strip_heredoc
        class #{migration_class} < ActiveRecord::Migration
          def self.up
            execute <<-SQL
            SQL
          end

          def self.down
          end
        end
      EOF
    end

    puts path
  end
end
