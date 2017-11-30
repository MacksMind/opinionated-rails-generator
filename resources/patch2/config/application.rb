diff --git a/config/application.rb b/config/application.rb
index 796b144..4ea755c 100644
--- a/config/application.rb
+++ b/config/application.rb
@@ -14,5 +14,10 @@ module Shiny
     # Settings in config/environments/* take precedence over those specified here.
     # Application configuration should go into files in config/initializers
     # -- all .rb files in that directory are automatically loaded.
+
+    config.app_name = Module.nesting.last.name
+    config.domain_name = "#{config.app_name.underscore.dasherize}.herokuapp.com"
+    config.email_sender = "noreply@#{config.domain_name}"
+    config.canonical_hostname = config.domain_name
   end
 end
