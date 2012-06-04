diff --git a/config/application.rb b/config/application.rb
index e3d3417..41b4b1a 100644
--- a/config/application.rb
+++ b/config/application.rb
@@ -56,6 +56,9 @@ module Shiny
     # Enable the asset pipeline
     config.assets.enabled = true
 
+    # Needed to make Heroku happy
+    config.assets.initialize_on_precompile = false
+
     # Version of your assets, change this if you want to expire all your assets
     config.assets.version = '1.0'
   end
