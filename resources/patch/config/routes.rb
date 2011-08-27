diff --git a/config/routes.rb b/config/routes.rb
index 0adb94d..857b7d0 100644
--- a/config/routes.rb
+++ b/config/routes.rb
@@ -2,6 +2,22 @@ Shiny::Application.routes.draw do
   # The priority is based upon order of creation:
   # first created -> highest priority.
 
+  resource :account, :only => [:edit, :update]
+
+  devise_for :users
+
+  namespace :admin do
+    resources :users
+    resources :contents do
+      collection do
+        post :sort
+      end
+    end
+  end
+
+  resources :contents, :only => :show
+  root :to => 'contents#show'
+
   # Sample of regular route:
   #   match 'products/:id' => 'catalog#view'
   # Keep in mind you can assign values other than :controller and :action
