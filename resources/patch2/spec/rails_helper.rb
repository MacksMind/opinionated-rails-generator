diff --git a/spec/rails_helper.rb b/spec/rails_helper.rb
index 00345af..446cd80 100644
--- a/spec/rails_helper.rb
+++ b/spec/rails_helper.rb
@@ -1,9 +1,13 @@
+# frozen_string_literal: true
+
+require 'simplecov'
+require 'pundit/rspec'
 # This file is copied to spec/ when you run 'rails generate rspec:install'
 require 'spec_helper'
 ENV['RAILS_ENV'] ||= 'test'
 require File.expand_path('../config/environment', __dir__)
 # Prevent database truncation if the environment is production
-abort("The Rails environment is running in production mode!") if Rails.env.production?
+abort('The Rails environment is running in production mode!') if Rails.env.production?
 require 'rspec/rails'
 # Add additional requires below this line. Rails is not loaded until this point!
 
@@ -33,6 +37,7 @@ end
 RSpec.configure do |config|
   # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
   config.fixture_path = "#{::Rails.root}/spec/fixtures"
+  config.global_fixtures = :all
 
   # If you're not using ActiveRecord, or you'd prefer not to run each of your
   # examples within a transaction, remove the following line or assign false
@@ -62,3 +67,6 @@ RSpec.configure do |config|
   # arbitrary gems may also be filtered via:
   # config.filter_gems_from_backtrace("gem name")
 end
+
+# Require support files after config because factories_spec.rb needs fixtures
+Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }
