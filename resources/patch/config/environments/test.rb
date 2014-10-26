diff --git a/config/environments/test.rb b/config/environments/test.rb
index 32756eb..ec2c274 100644
--- a/config/environments/test.rb
+++ b/config/environments/test.rb
@@ -39,4 +39,6 @@ Rails.application.configure do
 
   # Raises error for missing translations
   # config.action_view.raise_on_missing_translations = true
+
+  config.action_mailer.default_url_options = {host: 'localhost:3000'}
 end
