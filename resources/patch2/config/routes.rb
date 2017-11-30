diff --git a/config/routes.rb b/config/routes.rb
index 787824f..032f739 100644
--- a/config/routes.rb
+++ b/config/routes.rb
@@ -1,3 +1,16 @@
 Rails.application.routes.draw do
   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
+
+  resource :account, only: [:edit, :update]
+
+  namespace :admin do
+    resources :users do
+      member do
+        post :masquerade
+      end
+    end
+  end
+
+  resources :dashboard, only: [:index]
+  root to: "dashboard#welcome"
 end
