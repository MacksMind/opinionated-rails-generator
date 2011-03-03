diff --git a/config/application.rb b/config/application.rb
index c900841..a389af3 100644
--- a/config/application.rb
+++ b/config/application.rb
@@ -31,7 +31,7 @@ module Shiny
     # config.i18n.default_locale = :de
 
     # JavaScript files you want as :defaults (application.js is always included).
-    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)
+    config.action_view.javascript_expansions[:defaults] = %w(jquery.min rails)
 
     # Configure the default encoding used in templates for Ruby 1.9.
     config.encoding = "utf-8"
