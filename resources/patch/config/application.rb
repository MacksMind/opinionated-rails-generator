diff --git a/config/application.rb b/config/application.rb
index 33c87c0..f680dd3 100644
--- a/config/application.rb
+++ b/config/application.rb
@@ -19,5 +19,7 @@ module Shiny
     # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
     # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
     # config.i18n.default_locale = :de
+
+    config.i18n.enforce_available_locales = true
   end
 end
