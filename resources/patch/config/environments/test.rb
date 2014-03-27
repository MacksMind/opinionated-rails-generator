diff --git a/config/environments/test.rb b/config/environments/test.rb
index 1bf04fd..f937d57 100644
--- a/config/environments/test.rb
+++ b/config/environments/test.rb
@@ -33,4 +33,6 @@ Shiny::Application.configure do
 
   # Print deprecation notices to the stderr.
   config.active_support.deprecation = :stderr
+
+  config.action_mailer.default_url_options = {host: 'localhost:3000'}
 end
