diff --git a/config/environments/production.rb b/config/environments/production.rb
index b5f82c4..f5e4587 100644
--- a/config/environments/production.rb
+++ b/config/environments/production.rb
@@ -28,7 +29,7 @@ Shiny::Application.configure do
   # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx
 
   # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
-  # config.force_ssl = true
+  config.force_ssl = true
 
   # See everything in the log (default is :info)
   # config.log_level = :debug
