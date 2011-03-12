diff --git a/config/application.rb b/config/application.rb
index c900841..87c0f6e 100644
--- a/config/application.rb
+++ b/config/application.rb
@@ -32,6 +32,7 @@ module Shiny
 
     # JavaScript files you want as :defaults (application.js is always included).
     # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)
+    config.action_view.javascript_expansions[:defaults] = %w(rails)
 
     # Configure the default encoding used in templates for Ruby 1.9.
     config.encoding = "utf-8"
