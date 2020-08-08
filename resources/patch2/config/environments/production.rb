diff --git a/config/environments/production.rb b/config/environments/production.rb
index 06468f7..91dde88 100644
--- a/config/environments/production.rb
+++ b/config/environments/production.rb
@@ -44,7 +44,7 @@ Rails.application.configure do
   # config.action_cable.allowed_request_origins = [ 'http://example.com', /http:\/\/example.*/ ]
 
   # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
-  # config.force_ssl = true
+  config.force_ssl = true
 
   # Use the lowest log level to ensure availability of diagnostic information
   # when problems arise.
@@ -109,4 +109,20 @@ Rails.application.configure do
   # config.active_record.database_selector = { delay: 2.seconds }
   # config.active_record.database_resolver = ActiveRecord::Middleware::DatabaseSelector::Resolver
   # config.active_record.database_resolver_context = ActiveRecord::Middleware::DatabaseSelector::Resolver::Session
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
+  enable_starttls_auto: true
+}
