diff --git a/config/environments/development.rb b/config/environments/development.rb
index 2987450..fcb6af9 100644
--- a/config/environments/development.rb
+++ b/config/environments/development.rb
@@ -25,5 +25,5 @@ Shiny::Application.configure do
   # Debug mode disables concatenation and preprocessing of assets.
   # This option may cause significant delays in view rendering with a large
   # number of complex assets.
-  config.assets.debug = true
+  config.assets.debug = false
 end
