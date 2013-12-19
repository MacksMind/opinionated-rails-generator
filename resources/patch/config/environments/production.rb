diff --git a/config/environments/production.rb b/config/environments/production.rb
index 5784f5d..1fd2dd5 100644
--- a/config/environments/production.rb
+++ b/config/environments/production.rb
@@ -40,7 +40,7 @@ Shiny::Application.configure do
   # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx
 
   # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
-  # config.force_ssl = true
+  config.force_ssl = true
 
   # Set to :debug to see everything in the log.
   config.log_level = :info
@@ -77,4 +77,10 @@ Shiny::Application.configure do
 
   # Use default logging formatter so that PID and timestamp are not suppressed.
   config.log_formatter = ::Logger::Formatter.new
+
+  # Required for Heroku
+  config.assets.initialize_on_precompile = false
+
+  config.static_cache_control = "public, max-age=172800"
+  config.middleware.use Rack::Deflater
 end
