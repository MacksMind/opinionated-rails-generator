diff --git a/config/initializers/devise.rb b/config/initializers/devise.rb
index a684c46..f308364 100644
--- a/config/initializers/devise.rb
+++ b/config/initializers/devise.rb
@@ -12,7 +12,7 @@ Devise.setup do |config|
   # Configure the e-mail address which will be shown in Devise::Mailer,
   # note that it will be overwritten if you use your own mailer class
   # with default "from" parameter.
-  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
+  config.mailer_sender = Rails.application.config.email_sender
 
   # Configure the class responsible to send e-mails.
   # config.mailer = 'Devise::Mailer'
