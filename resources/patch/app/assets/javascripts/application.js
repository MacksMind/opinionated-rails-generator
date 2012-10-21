diff --git a/app/assets/javascripts/application.js b/app/assets/javascripts/application.js
index 9097d83..56eb81b 100644
--- a/app/assets/javascripts/application.js
+++ b/app/assets/javascripts/application.js
@@ -13,3 +13,6 @@
 //= require jquery
 //= require jquery_ujs
 //= require_tree .
+
+//Kludge to fix dropdowns on iOS - See https://github.com/twitter/bootstrap/issues/2975
+$('body').on('touchstart.dropdown', '.dropdown-menu', function (e) { e.stopPropagation(); });
