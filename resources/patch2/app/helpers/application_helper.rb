diff --git a/app/helpers/application_helper.rb b/app/helpers/application_helper.rb
index de6be79..190fd66 100644
--- a/app/helpers/application_helper.rb
+++ b/app/helpers/application_helper.rb
@@ -1,2 +1,9 @@
 module ApplicationHelper
+  include LetterAvatar::AvatarHelper
+
+  def gravatar_tag(email, full_name, size = 32)
+    email_address = email.downcase
+    hash = Digest::MD5.hexdigest(email_address)
+    image_tag "https://www.gravatar.com/avatar/#{hash}?s=#{size}&d=404", onerror: "this.onerror=null;this.src='#{letter_avatar_url(full_name, size)}';"
+  end
 end
