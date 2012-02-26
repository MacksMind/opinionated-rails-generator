diff --git a/spec/spec_helper.rb b/spec/spec_helper.rb
index e66d980..ea2a5ee 100644
--- a/spec/spec_helper.rb
+++ b/spec/spec_helper.rb
@@ -1,3 +1,4 @@
+require 'simplecov'
 # This file is copied to spec/ when you run 'rails generate rspec:install'
 ENV["RAILS_ENV"] ||= 'test'
 require File.expand_path("../../config/environment", __FILE__)
@@ -19,6 +20,7 @@ RSpec.configure do |config|
 
   # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
   config.fixture_path = "#{::Rails.root}/spec/fixtures"
+  config.global_fixtures = :all
 
   # If you're not using ActiveRecord, or you'd prefer not to run each of your
   # examples within a transaction, remove the following line or assign false
