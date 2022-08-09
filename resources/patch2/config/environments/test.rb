diff --git a/config/environments/test.rb b/config/environments/test.rb
index f38e419..95199f2 100644
--- a/config/environments/test.rb
+++ b/config/environments/test.rb
@@ -61,4 +61,6 @@
 
   # Annotate rendered view with file names.
   # config.action_view.annotate_rendered_view_with_filenames = true
+
+  config.action_mailer.default_url_options = { host: 'localhost:3000' }
 end
