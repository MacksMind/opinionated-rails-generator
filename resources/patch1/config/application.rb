diff --git a/config/application.rb b/config/application.rb
index 2124c3a..1fd046c 100644
--- a/config/application.rb
+++ b/config/application.rb
@@ -15,5 +15,10 @@ module OpinionatedRails
     # Application configuration can go into files in config/initializers
     # -- all .rb files in that directory are automatically loaded after loading
     # the framework and any gems in your application.
+
+    config.app_name = Module.nesting.last.name
+    config.hostname = "#{ENV['HEROKU_APP_NAME']}.herokuapp.com" || ENV['HOST_NAME'] || 'app.example.com'
+    config.email_domain = config.hostname
+    config.email_sender = "noreply@#{config.email_domain}"
   end
 end
