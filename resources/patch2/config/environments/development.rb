diff --git a/config/environments/development.rb b/config/environments/development.rb
index 722f2bd..bc4d82f 100644
--- a/config/environments/development.rb
+++ b/config/environments/development.rb
@@ -71,4 +71,6 @@
 
   # Uncomment if you wish to allow Action Cable access from any origin.
   # config.action_cable.disable_request_forgery_protection = true
+
+  config.action_mailer.default_url_options = { host: 'localhost:3000' }
 end
