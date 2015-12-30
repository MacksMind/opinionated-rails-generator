diff --git a/config/routes.rb b/config/routes.rb
index 8293c8a..2aa9f0f 100644
--- a/config/routes.rb
+++ b/config/routes.rb
@@ -1,6 +1,19 @@
 Rails.application.routes.draw do
   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 
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
+  get ':action' => 'dashboard', as: :dashboard
+  root to: 'dashboard#index'
+
   # Serve websocket cable requests in-process
   # mount ActionCable.server => '/cable'
 end
