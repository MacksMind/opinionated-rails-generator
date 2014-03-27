diff --git a/config/environments/development.rb b/config/environments/development.rb
index 2987450..273857a 100644
--- a/config/environments/development.rb
+++ b/config/environments/development.rb
@@ -11,7 +11,7 @@ Shiny::Application.configure do
 
   # Show full error reports and disable caching.
   config.consider_all_requests_local       = true
-  config.action_controller.perform_caching = false
+  config.action_controller.perform_caching = true
 
   # Don't care if the mailer can't send.
   config.action_mailer.raise_delivery_errors = false
@@ -25,5 +25,7 @@ Shiny::Application.configure do
   # Debug mode disables concatenation and preprocessing of assets.
   # This option may cause significant delays in view rendering with a large
   # number of complex assets.
-  config.assets.debug = true
+  config.assets.debug = false
+
+  config.action_mailer.default_url_options = {host: 'localhost:3000'}
 end
