diff --git a/app/controllers/application_controller.rb b/app/controllers/application_controller.rb
index d83690e..beed3f3 100644
--- a/app/controllers/application_controller.rb
+++ b/app/controllers/application_controller.rb
@@ -2,4 +2,40 @@ class ApplicationController < ActionController::Base
   # Prevent CSRF attacks by raising an exception.
   # For APIs, you may want to use :null_session instead.
   protect_from_forgery with: :exception
+
+  before_filter :set_time_zone
+  check_authorization :unless => :devise_controller?
+  before_filter :configure_permitted_parameters, if: :devise_controller?
+
+  protected
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
+
+  # Strong parameters for devise
+  def configure_permitted_parameters
+    devise_parameter_sanitizer.for(:sign_up) \
+      << :first_name \
+      << :last_name \
+      << :time_zone \
+      << :phone_number \
+      << :company_name \
+      << :title \
+      << :address_line_1 \
+      << :address_line_2 \
+      << :city \
+      << :state_id \
+      << :postal_code \
+      << :country_id
+  end
 end
