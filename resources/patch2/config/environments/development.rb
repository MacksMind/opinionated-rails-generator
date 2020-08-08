diff --git a/config/environments/development.rb b/config/environments/development.rb
index 66df51f..e93ad6c 100644
--- a/config/environments/development.rb
+++ b/config/environments/development.rb
@@ -59,4 +59,6 @@ Rails.application.configure do
   # Use an evented file watcher to asynchronously detect changes in source code,
   # routes, locales, etc. This feature depends on the listen gem.
   config.file_watcher = ActiveSupport::EventedFileUpdateChecker
+
+  config.action_mailer.default_url_options = { host: 'localhost:3000' }
 end
