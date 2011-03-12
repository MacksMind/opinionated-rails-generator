diff --git a/spec/spec_helper.rb b/spec/spec_helper.rb
index 9b8b02c..84faa1d 100644
--- a/spec/spec_helper.rb
+++ b/spec/spec_helper.rb
@@ -19,6 +19,7 @@ RSpec.configure do |config|
 
   # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
   config.fixture_path = "#{::Rails.root}/spec/fixtures"
+  config.global_fixtures = :all
 
   # If you're not using ActiveRecord, or you'd prefer not to run each of your
   # examples within a transaction, remove the following line or assign false
