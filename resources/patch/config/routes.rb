diff --git a/config/routes.rb b/config/routes.rb
index 644907a..ce16957 100644
--- a/config/routes.rb
+++ b/config/routes.rb
@@ -1,4 +1,17 @@
 Shiny::Application.routes.draw do
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
   # The priority is based upon order of creation: first created -> highest priority.
   # See how all your routes lay out with "rake routes".
 
