diff --git a/config/environments/production.rb b/config/environments/production.rb
index 5c1b32e..1f796ea 100644
--- a/config/environments/production.rb
+++ b/config/environments/production.rb
@@ -42,7 +42,7 @@ Rails.application.configure do
   # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX
 
   # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
-  # config.force_ssl = true
+  config.force_ssl = true
 
   # Use the lowest log level to ensure availability of diagnostic information
   # when problems arise.
@@ -75,5 +75,10 @@ Rails.application.configure do
   config.log_formatter = ::Logger::Formatter.new
 
   # Do not dump schema after migrations.
   config.active_record.dump_schema_after_migration = false
+
+  config.static_cache_control = "public, max-age=172800"
+  config.middleware.use Rack::Deflater
+
+  config.action_mailer.default_url_options = {host: config.canonical_hostname, protocol: 'https'}
 end
