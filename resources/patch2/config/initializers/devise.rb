diff --git a/config/initializers/devise.rb b/config/initializers/devise.rb
index 75142de..a1754c0 100644
--- a/config/initializers/devise.rb
+++ b/config/initializers/devise.rb
@@ -18,7 +18,7 @@ Devise.setup do |config|
   # Configure the e-mail address which will be shown in Devise::Mailer,
   # note that it will be overwritten if you use your own mailer class
   # with default "from" parameter.
-  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
+  config.mailer_sender = Rails.application.config.email_sender
 
   # Configure the class responsible to send e-mails.
   # config.mailer = 'Devise::Mailer'
@@ -118,9 +118,9 @@ Devise.setup do |config|
 
   # Send a notification to the original email when the user's email is changed.
-  # config.send_email_changed_notification = false
+  config.send_email_changed_notification = true
 
   # Send a notification email when the user's password is changed.
-  # config.send_password_change_notification = false
+  config.send_password_change_notification = true
 
   # ==> Configuration for :confirmable
   # A period that the user is allowed to access the website even without
@@ -128,7 +128,7 @@ Devise.setup do |config|
   # able to access the website for two days without confirming their account,
   # access will be blocked just in the third day. Default is 0.days, meaning
   # the user cannot access the website without confirming their account.
-  # config.allow_unconfirmed_access_for = 2.days
+  config.allow_unconfirmed_access_for = 2.days
 
   # A period that the user is allowed to confirm their account before their
   # token becomes invalid. For example, if set to 3.days, the user can confirm
@@ -136,7 +136,7 @@ Devise.setup do |config|
   # their account can't be confirmed with the token any more.
   # Default is nil, meaning there is no restriction on how long a user can take
   # before confirming their account.
-  # config.confirm_within = 3.days
+  config.confirm_within = 3.days
 
   # If true, requires any email changes to be confirmed (exactly the same way as
   # initial account confirmation) to be applied. Requires additional unconfirmed_email
