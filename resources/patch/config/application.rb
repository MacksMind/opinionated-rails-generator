diff --git a/config/application.rb b/config/application.rb
index e654db3..82ee6b7 100644
--- a/config/application.rb
+++ b/config/application.rb
@@ -53,6 +53,9 @@ module Shiny
     # Enable the asset pipeline
     config.assets.enabled = true
 
+    # Needed to make Heroku happy
+    config.assets.initialize_on_precompile = false
+
     # Version of your assets, change this if you want to expire all your assets
     config.assets.version = '1.0'
   end
