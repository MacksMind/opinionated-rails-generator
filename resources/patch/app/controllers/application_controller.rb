diff --git a/app/controllers/application_controller.rb b/app/controllers/application_controller.rb
index e8065d9..fd9819e 100644
--- a/app/controllers/application_controller.rb
+++ b/app/controllers/application_controller.rb
@@ -1,3 +1,20 @@
 class ApplicationController < ActionController::Base
   protect_from_forgery
+  before_filter :set_time_zone
+  check_authorization :unless => :devise_controller?
+
+  private
+
+  def stored_location_for(resource_or_scope)
+    params[:return_to] || super
+  end
+
+  helper_method :user_root_path
+  def user_root_path
+    contents_path :action => 'home'
+  end
+
+  def set_time_zone
+    Time.zone = current_user.time_zone if user_signed_in?
+  end
 end
