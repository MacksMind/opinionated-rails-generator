diff --git a/spec/rails_helper.rb b/spec/rails_helper.rb
index b98cb0f..29a09cb 100644
--- a/spec/rails_helper.rb
+++ b/spec/rails_helper.rb
@@ -1,3 +1,4 @@
+require 'simplecov'
 # This file is copied to spec/ when you run 'rails generate rspec:install'
 ENV["RAILS_ENV"] ||= 'test'
 require 'spec_helper'
@@ -20,6 +21,7 @@ ActiveRecord::Migration.maintain_test_schema!
 RSpec.configure do |config|
   # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
   config.fixture_path = "#{::Rails.root}/spec/fixtures"
+  config.global_fixtures = :all
 
   # If you're not using ActiveRecord, or you'd prefer not to run each of your
   # examples within a transaction, remove the following line or assign false
