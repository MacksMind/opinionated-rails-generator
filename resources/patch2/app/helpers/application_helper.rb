diff --git a/app/helpers/application_helper.rb b/app/helpers/application_helper.rb
index de6be79..f777bf1 100644
--- a/app/helpers/application_helper.rb
+++ b/app/helpers/application_helper.rb
@@ -1,2 +1,15 @@
 module ApplicationHelper
+  include LetterAvatar::AvatarHelper
+
+  def gravatar_tag(email, full_name, size: 32, css_class: "rounded")
+    email_address = email.downcase
+    hash = Digest::MD5.hexdigest(email_address)
+    image_tag(
+      "https://www.gravatar.com/avatar/#{hash}?s=#{size}&d=404",
+      onerror: "this.onerror=null;this.src='#{avatar_name_path(full_name: full_name, s: size)}';",
+      alt: "Gravatar for #{email}",
+      class: css_class,
+      size: "#{size}x#{size}"
+    )
+  end
 end
