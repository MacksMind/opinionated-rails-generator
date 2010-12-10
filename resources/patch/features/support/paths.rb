diff --git a/features/support/paths.rb b/features/support/paths.rb
index 06b3efb..353e04e 100644
--- a/features/support/paths.rb
+++ b/features/support/paths.rb
@@ -17,6 +17,16 @@ module NavigationHelpers
     #   when /^(.*)'s profile page$/i
     #     user_profile_path(User.find_by_login($1))
 
+    when /my password reset page/i
+      account_password_reset_path(@user.perishable_token)
+    when /my edit password reset page/i
+      edit_account_password_reset_path(@user.perishable_token)
+    when /an invalid edit password reset page/i
+      edit_account_password_reset_path("blah")
+    when /my account confirmation page/i
+      edit_account_confirmation_path(@user.perishable_token)
+    when /an invalid account confirmation page/i
+      edit_account_confirmation_path("blah")
     else
       begin
         page_name =~ /the (.*) page/
