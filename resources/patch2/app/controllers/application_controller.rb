diff --git a/app/controllers/application_controller.rb b/app/controllers/application_controller.rb
index 09705d1..117a941 100644
--- a/app/controllers/application_controller.rb
+++ b/app/controllers/application_controller.rb
@@ -1,2 +1,51 @@
+# frozen_string_literal: true
+
 class ApplicationController < ActionController::Base
+  include Pundit::Authorization
+
+  before_action :set_time_zone
+  before_action :redirect_invalid_user
+  before_action :configure_permitted_parameters, if: :devise_controller?
+
+  after_action :verify_authorized, except: :index, unless: :devise_controller?
+  after_action :verify_policy_scoped, only: :index, unless: :devise_controller?
+
+protected
+
+  helper_method :signed_in_root_path
+  def signed_in_root_path(_resource = User)
+    dashboard_index_path
+  end
+
+  def set_time_zone
+    Time.zone = current_user.time_zone if user_signed_in?
+  end
+
+  def redirect_invalid_user
+    return if !current_user || current_user.valid?
+
+    flash[:warning] = 'Your profile is incomplete'
+    redirect_to edit_account_url
+  end
+
+  # Strong parameters for devise
+  def configure_permitted_parameters
+    devise_parameter_sanitizer.permit(
+      :sign_up,
+      keys: %i[
+        first_name
+        last_name
+        time_zone
+        phone_number
+        company_name
+        title
+        address_line1
+        address_line2
+        city
+        state_id
+        postal_code
+        country_code
+      ]
+    )
+  end
 end
