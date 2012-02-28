diff --git a/config/routes.rb b/config/routes.rb
index 8fc9c3d..d0c180c 100644
--- a/config/routes.rb
+++ b/config/routes.rb
@@ -2,6 +2,24 @@ Shiny::Application.routes.draw do
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
+    resources :contents do
+      collection do
+        post :sort
+      end
+    end
+  end
+
+  get ':id' => 'contents#show', :as => "content"
+  root :to => 'contents#show'
+
   # Sample of regular route:
   #   match 'products/:id' => 'catalog#view'
   # Keep in mind you can assign values other than :controller and :action
