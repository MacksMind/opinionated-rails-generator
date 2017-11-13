diff --git a/config/environments/production.rb b/config/environments/production.rb
index 2bcc21a..836c25b 100644
--- a/config/environments/production.rb
+++ b/config/environments/production.rb
@@ -45,7 +45,7 @@ Rails.application.configure do
   # config.action_cable.allowed_request_origins = [ 'http://example.com', /http:\/\/example.*/ ]
 
   # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
-  # config.force_ssl = true
+  config.force_ssl = true
 
   # Use the lowest log level to ensure availability of diagnostic information
   # when problems arise.
@@ -88,4 +88,20 @@ Rails.application.configure do
 
   # Do not dump schema after migrations.
   config.active_record.dump_schema_after_migration = false
+
+  config.static_cache_control = "public, max-age=172800"
+  config.middleware.use Rack::Deflater
+
+  config.action_mailer.default_url_options = { host: config.canonical_hostname, protocol: 'https' }
 end
+
+# Heroku
+# ActionMailer::Base.smtp_settings = {
+#   address:              'smtp.sendgrid.net',
+#   port:                 '587',
+#   authentication:       :plain,
+#   user_name:            ENV['SENDGRID_USERNAME'],
+#   password:             ENV['SENDGRID_PASSWORD'],
+#   domain:               'heroku.com',
+#   enable_starttls_auto: true
+# }
