diff --git a/config/environments/production.rb b/config/environments/production.rb
index 7e47f62..900c049 100644
--- a/config/environments/production.rb
+++ b/config/environments/production.rb
@@ -41,7 +41,7 @@ Rails.application.configure do
   # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX
 
   # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
-  # config.force_ssl = true
+  config.force_ssl = true
 
   # Use the lowest log level to ensure availability of diagnostic information
   # when problems arise.
@@ -74,5 +74,10 @@ Rails.application.configure do
   config.log_formatter = ::Logger::Formatter.new
 
   # Do not dump schema after migrations.
-  config.active_record.dump_schema_after_migration = false
+  config.active_record.dump_schema_after_migration = true
+
+  config.static_cache_control = "public, max-age=172800"
+  config.middleware.use Rack::Deflater
+
+  config.action_mailer.default_url_options = {host: config.canonical_hostname, protocol: 'https'}
 end
