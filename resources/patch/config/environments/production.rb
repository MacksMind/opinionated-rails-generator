diff --git a/config/environments/production.rb b/config/environments/production.rb
index b5f82c4..f5e4587 100644
--- a/config/environments/production.rb
+++ b/config/environments/production.rb
@@ -10,6 +10,7 @@ Shiny::Application.configure do
 
   # Disable Rails's static asset server (Apache or nginx will already do this)
   config.serve_static_assets = false
+  config.static_cache_control = "public, max-age=172800"
 
   # Compress JavaScripts and CSS
   config.assets.compress = true
@@ -28,7 +29,7 @@ Shiny::Application.configure do
   # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx
 
   # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
-  # config.force_ssl = true
+  config.force_ssl = true
 
   # See everything in the log (default is :info)
   # config.log_level = :debug
@@ -64,4 +65,6 @@ Shiny::Application.configure do
   # Log the query plan for queries taking more than this (works
   # with SQLite, MySQL, and PostgreSQL)
   # config.active_record.auto_explain_threshold_in_seconds = 0.5
+
+  config.middleware.use Rack::Deflater
 end
