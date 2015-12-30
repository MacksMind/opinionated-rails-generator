diff --git a/config/environments/development.rb b/config/environments/development.rb
index c9d06f3..800958d 100644
--- a/config/environments/development.rb
+++ b/config/environments/development.rb
@@ -36,7 +36,7 @@ Rails.application.configure do
   # Debug mode disables concatenation and preprocessing of assets.
   # This option may cause significant delays in view rendering with a large
   # number of complex assets.
-  config.assets.debug = true
+  config.assets.debug = false
 
   # Asset digests allow you to set far-future HTTP expiration dates on all assets,
   # yet still be able to expire them through the digest params.
@@ -53,4 +53,6 @@ Rails.application.configure do
   # Use an evented file watcher to asynchronously detect changes in source code,
   # routes, locales, etc. This feature depends on the listen gem.
   # config.file_watcher = ActiveSupport::EventedFileUpdateChecker
+
+  config.action_mailer.default_url_options = {host: 'localhost:3000'}
 end
