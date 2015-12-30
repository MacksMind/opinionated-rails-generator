diff --git a/config/application.rb b/config/application.rb
index ebfeaf7..6b09068 100644
--- a/config/application.rb
+++ b/config/application.rb
@@ -11,5 +11,12 @@ module Shiny
     # Settings in config/environments/* take precedence over those specified here.
     # Application configuration should go into files in config/initializers
     # -- all .rb files in that directory are automatically loaded.
+
+    config.action_view.field_error_proc = Proc.new { |html_tag, instance| "<div class=\"field_with_errors has-error\">#{html_tag}</div>".html_safe }
+
+    config.app_name = Module.nesting.last.name
+    config.domain_name = "#{config.app_name.downcase}.com"
+    config.email_sender = "noreply@#{config.domain_name}"
+    config.canonical_hostname = "www.#{config.domain_name}"
   end
 end
