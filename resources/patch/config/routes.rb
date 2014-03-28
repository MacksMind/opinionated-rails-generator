diff --git a/config/routes.rb b/config/routes.rb
index 3f66539..5e87a41 100644
--- a/config/routes.rb
+++ b/config/routes.rb
@@ -2,6 +2,19 @@ Rails.application.routes.draw do
   # The priority is based upon order of creation: first created -> highest priority.
   # See how all your routes lay out with "rake routes".
 
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
+  get ':action' => 'contents', as: :contents
+  root to: 'contents#index'
+
   # You can have the root of your site routed with "root"
   # root 'welcome#index'
 
