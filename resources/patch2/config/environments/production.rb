diff --git a/config/environments/production.rb b/config/environments/production.rb
index 372acf3..9536a68 100644
--- a/config/environments/production.rb
+++ b/config/environments/production.rb
@@ -46,7 +46,7 @@
   # config.action_cable.allowed_request_origins = [ "http://example.com", /http:\/\/example.*/ ]
 
   # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
-  # config.force_ssl = true
+  config.force_ssl = true
 
   # Include generic and useful information about system operation, but avoid logging too much
   # information to avoid inadvertent exposure of personally identifiable information (PII).
@@ -90,4 +90,20 @@
 
   # Do not dump schema after migrations.
   config.active_record.dump_schema_after_migration = false
+
+  config.static_cache_control = 'public, max-age=172800'
+  config.middleware.use Rack::Deflater
+
+  config.action_mailer.default_url_options = { host: config.hostname, protocol: :https }
 end
+
+# Heroku
+ActionMailer::Base.smtp_settings = {
+  address:              'smtp.sendgrid.net',
+  port:                 '587',
+  authentication:       :plain,
+  user_name:            ENV['SENDGRID_USERNAME'],
+  password:             ENV['SENDGRID_PASSWORD'],
+  domain:               'heroku.com',
+  enable_starttls_auto: true,
+}
