# frozen_string_literal: true

namespace :db do
  namespace :fixtures do
    desc 'Set FIXTURES_PATH environment variable'
    task set_fixtures_path: :environment do
      ActiveRecord::Tasks::DatabaseTasks.fixtures_path = File.join('spec', 'fixtures')
    end

    task load: :set_fixtures_path

    desc 'Create YAML test fixtures from data in an existing database.
    Defaults to development database.  Set RAILS_ENV to override.'
    task dump: :set_fixtures_path do
      skip_tables = %w[schema_migrations ar_internal_metadata]
      ActiveRecord::Base.establish_connection
      tables = ENV['TABLES']&.split(',')
      tables ||= (ActiveRecord::Base.connection.tables - skip_tables)

      tables.each do |table_name|
        counter = '00000'
        File.open(Rails.root.join('spec/fixtures', "#{table_name}.yml"), 'w') do |file|
          pkey = ActiveRecord::Base.connection.primary_key(table_name)
          sql = "SELECT * FROM #{table_name}"
          sql += " ORDER BY #{pkey}" if pkey
          data = ActiveRecord::Base.connection.select_all(sql)
          file.write data.each_with_object({}) { |record, hash|
            hash_key = "#{table_name}_#{record[pkey] || counter = counter.succ}"
            hash[hash_key] = record
          }.to_yaml
        end
      end
    end
  end
end
