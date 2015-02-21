diff --git a/config/application.rb b/config/application.rb
index 390f74d..39bbc17 100644
--- a/config/application.rb
+++ b/config/application.rb
@@ -22,5 +22,12 @@ module Shiny
 
     # Do not swallow errors in after_commit/after_rollback callbacks.
     config.active_record.raise_in_transactional_callbacks = true
+
+    config.action_view.field_error_proc = Proc.new { |html_tag, instance| "<div class=\"field_with_errors has-error\">#{html_tag}</div>".html_safe }
+
+    config.app_name = Module.nesting.last.name
+    config.domain_name = "#{config.app_name.downcase}.com"
+    config.email_sender = "noreply@#{config.domain_name}"
+    config.canonical_hostname = "www.#{config.domain_name}"
   end
 end
