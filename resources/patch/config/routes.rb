diff --git a/config/routes.rb b/config/routes.rb
index 787824f..f959372 100644
--- a/config/routes.rb
+++ b/config/routes.rb
@@ -1,3 +1,19 @@
 Rails.application.routes.draw do
   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
+
+  resource :account, only: [:edit, :update]
+
+  namespace :admin do
+   resources :users do
+     member do
+       post :masquerade
+     end
+   end
+  end
+
+  %w{home}.each do |page|
+    get page => "dashboard##{page}", as: "dashboard_#{page}"
+  end
+
+  root to: 'dashboard#index'
 end
