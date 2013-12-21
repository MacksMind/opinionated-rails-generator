diff --git a/app/assets/javascripts/application.js b/app/assets/javascripts/application.js
index d6925fa..c0c67e6 100644
--- a/app/assets/javascripts/application.js
+++ b/app/assets/javascripts/application.js
@@ -10,7 +10,9 @@
 // Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
 // about supported directives.
 //
-//= require jquery
 //= require jquery_ujs
 //= require turbolinks
 //= require_tree .
+
+//Kludge to fix dropdowns on iOS - See https://github.com/twitter/bootstrap/issues/2975
+$('body').on('touchstart.dropdown', '.dropdown-menu', function (e) { e.stopPropagation(); });
