diff --git a/app/controllers/application_controller.rb b/app/controllers/application_controller.rb
index d83690e..36db0f9 100644
--- a/app/controllers/application_controller.rb
+++ b/app/controllers/application_controller.rb
@@ -1,5 +1,42 @@
 class ApplicationController < ActionController::Base
+  include Pundit
   # Prevent CSRF attacks by raising an exception.
   # For APIs, you may want to use :null_session instead.
   protect_from_forgery with: :exception
+
+  before_action :set_time_zone
+
+  after_action :verify_authorized, except: :index, unless: :devise_controller?
+  after_action :verify_policy_scoped, only: :index, unless: :devise_controller?
+
+  before_action :configure_permitted_parameters, if: :devise_controller?
+
+  protected
+
+  helper_method :signed_in_root_path
+  def signed_in_root_path(resource=User)
+    dashboard_path(action: 'home')
+  end
+
+  def set_time_zone
+    Time.zone = current_user.time_zone if user_signed_in?
+  end
+
+  # Strong parameters for devise
+  def configure_permitted_parameters
+    devise_parameter_sanitizer.permit(:sign_up, keys: [
+      :first_name,
+      :last_name,
+      :time_zone,
+      :phone_number,
+      :company_name,
+      :title,
+      :address_line_1,
+      :address_line_2,
+      :city,
+      :state_id,
+      :postal_code,
+      :country_id,
+    ])
+  end
 end
