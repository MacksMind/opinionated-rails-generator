diff --git a/features/support/paths.rb b/features/support/paths.rb
index ee9b251..b1675cb 100644
--- a/features/support/paths.rb
+++ b/features/support/paths.rb
@@ -9,7 +9,7 @@ module NavigationHelpers
     case page_name
 
     when /^the home\s?page$/
-      '/'
+      root_path
 
     # Add more mappings here.
     # Here is an example that pulls values out of the Regexp:
