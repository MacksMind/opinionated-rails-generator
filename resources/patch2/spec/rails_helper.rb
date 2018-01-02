diff --git a/spec/rails_helper.rb b/spec/rails_helper.rb
index bbe1ba5..abae20c 100644
--- a/spec/rails_helper.rb
+++ b/spec/rails_helper.rb
@@ -1,3 +1,5 @@
+require "simplecov"
+require "pundit/rspec"
 # This file is copied to spec/ when you run 'rails generate rspec:install'
 require 'spec_helper'
 ENV['RAILS_ENV'] ||= 'test'
@@ -29,6 +31,7 @@ ActiveRecord::Migration.maintain_test_schema!
 RSpec.configure do |config|
   # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
   config.fixture_path = "#{::Rails.root}/spec/fixtures"
+  config.global_fixtures = :all
 
   # If you're not using ActiveRecord, or you'd prefer not to run each of your
   # examples within a transaction, remove the following line or assign false
@@ -55,3 +55,6 @@ RSpec.configure do |config|
   # arbitrary gems may also be filtered via:
   # config.filter_gems_from_backtrace("gem name")
 end
+
+# Require support files after config because factories_spec.rb needs fixtures
+Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
