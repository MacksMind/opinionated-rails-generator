diff --git a/config/environments/production.rb b/config/environments/production.rb
index 47d3553..7e3d008 100644
--- a/config/environments/production.rb
+++ b/config/environments/production.rb
@@ -40,7 +40,7 @@ Rails.application.configure do
   # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx
 
   # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
-  # config.force_ssl = true
+  config.force_ssl = true
 
   # Set to :debug to see everything in the log.
   config.log_level = :info
@@ -79,5 +79,10 @@ Rails.application.configure do
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
