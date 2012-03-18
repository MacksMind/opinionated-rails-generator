diff --git a/config/routes.rb b/config/routes.rb
index 8fc9c3d..a1e39b3 100644
--- a/config/routes.rb
+++ b/config/routes.rb
@@ -1,7 +1,22 @@
 Shiny::Application.routes.draw do
+  devise_for :users
+
   # The priority is based upon order of creation:
   # first created -> highest priority.
 
+  resource :account, :only => [:edit, :update]
+
+  namespace :admin do
+    resources :users do
+      member do
+        post :masquerade
+      end
+    end
+  end
+
+  get ':action' => 'contents', :as => :contents
+  root :to => 'contents#index'
+
   # Sample of regular route:
   #   match 'products/:id' => 'catalog#view'
   # Keep in mind you can assign values other than :controller and :action
