diff --git a/config/environments/production.rb b/config/environments/production.rb
index efd63a1..c6d26cf 100644
--- a/config/environments/production.rb
+++ b/config/environments/production.rb
@@ -43,7 +43,7 @@ Rails.application.configure do
   # config.action_cable.allowed_request_origins = [ 'http://example.com', /http:\/\/example.*/ ]
 
   # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
-  # config.force_ssl = true
+  config.force_ssl = true
 
   # Use the lowest log level to ensure availability of diagnostic information
   # when problems arise.
@@ -79,4 +79,9 @@ Rails.application.configure do
 
   # Do not dump schema after migrations.
   config.active_record.dump_schema_after_migration = false
+
+  config.static_cache_control = "public, max-age=172800"
+  config.middleware.use Rack::Deflater
+
+  config.action_mailer.default_url_options = {host: config.canonical_hostname, protocol: 'https'}
 end
