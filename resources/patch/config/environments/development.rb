diff --git a/config/environments/development.rb b/config/environments/development.rb
index 1b8ba05..fdb79ee 100644
--- a/config/environments/development.rb
+++ b/config/environments/development.rb
@@ -33,5 +33,5 @@ Shiny::Application.configure do
   config.assets.compress = false
 
   # Expands the lines which load the assets
-  config.assets.debug = true
+  config.assets.debug = false
 end
