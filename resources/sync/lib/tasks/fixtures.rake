# frozen_string_literal: true

namespace :db do
  namespace :fixtures do

    desc "Set FIXTURES_PATH environment variable"
    task set_fixtures_path: :environment do
      ActiveRecord::Tasks::DatabaseTasks.fixtures_path = File.join("spec", "fixtures")
    end

    task load: :set_fixtures_path

    desc 'Create YAML test fixtures from data in an existing database.
    Defaults to development database.  Set RAILS_ENV to override.'
    task dump: :set_fixtures_path do
      sql = "SELECT * FROM %s"
      skip_tables = %w{schema_migrations ar_internal_metadata}
      ActiveRecord::Base.establish_connection
      tables = ENV["TABLES"] && ENV["TABLES"].split(",")
      tables ||= (ActiveRecord::Base.connection.tables - skip_tables)

      tables.each do |table_name|
        i = "000"
        File.open("#{Rails.root}/spec/fixtures/#{table_name}.yml", "w") do |file|
          data = ActiveRecord::Base.connection.select_all(sql % table_name)
          file.write data.inject({}) { |hash, record|
            hash_key = "#{table_name}_#{record["id"] || record["uuid"] || i = i.succ}"
            hash[hash_key] = record
            hash
          }.to_yaml
        end
      end
    end
  end
end
