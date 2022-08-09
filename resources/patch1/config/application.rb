diff --git a/config/application.rb b/config/application.rb
index 6b45684..67d529d 100644
--- a/config/application.rb
+++ b/config/application.rb
@@ -18,5 +18,10 @@ class Application < Rails::Application
     #
     # config.time_zone = "Central Time (US & Canada)"
     # config.eager_load_paths << Rails.root.join("extras")
+
+    config.app_name = Module.nesting.last.name
+    config.hostname = "#{ENV['HEROKU_APP_NAME']}.herokuapp.com" || ENV['HOST_NAME'] || 'app.example.com'
+    config.email_domain = config.hostname
+    config.email_sender = "noreply@#{config.email_domain}"
   end
 end
