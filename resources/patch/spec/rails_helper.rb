diff --git a/spec/rails_helper.rb b/spec/rails_helper.rb
index 88ff2d0..ac09b50 100644
--- a/spec/rails_helper.rb
+++ b/spec/rails_helper.rb
@@ -1,3 +1,4 @@
+require 'simplecov'
 # This file is copied to spec/ when you run 'rails generate rspec:install'
 ENV['RAILS_ENV'] ||= 'test'
 require File.expand_path('../../config/environment', __FILE__)
@@ -20,7 +21,7 @@ require 'rspec/rails'
 # directory. Alternatively, in the individual `*_spec.rb` files, manually
 # require only the support files necessary.
 #
-# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
+Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
 
 # Checks for pending migrations before tests are run.
 # If you are not using ActiveRecord, you can remove this line.
@@ -29,6 +30,7 @@ ActiveRecord::Migration.maintain_test_schema!
 RSpec.configure do |config|
   # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
   config.fixture_path = "#{::Rails.root}/spec/fixtures"
+  config.global_fixtures = :all
 
   # If you're not using ActiveRecord, or you'd prefer not to run each of your
   # examples within a transaction, remove the following line or assign false
