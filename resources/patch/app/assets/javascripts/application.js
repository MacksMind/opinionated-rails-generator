diff --git a/app/assets/javascripts/application.js b/app/assets/javascripts/application.js
index d6925fa..9af7079 100644
--- a/app/assets/javascripts/application.js
+++ b/app/assets/javascripts/application.js
@@ -14,3 +14,6 @@
 //= require jquery_ujs
 //= require turbolinks
 //= require_tree .
+
+//Kludge to fix dropdowns on iOS - See https://github.com/twitter/bootstrap/issues/2975
+$('body').on('touchstart.dropdown', '.dropdown-menu', function (e) { e.stopPropagation(); });
