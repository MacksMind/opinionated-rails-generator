diff --git a/app/helpers/application_helper.rb b/app/helpers/application_helper.rb
index de6be79..ebc30fc 100644
--- a/app/helpers/application_helper.rb
+++ b/app/helpers/application_helper.rb
@@ -1,2 +1,7 @@
 module ApplicationHelper
+  def menu_link(name, options = {}, html_options = {})
+    link_to_unless_current(name, options, html_options) do
+      raw "<span>#{name}</span>"
+    end
+  end
 end
