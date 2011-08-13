diff --git a/config/routes.rb b/config/routes.rb
index 0adb94d..844c5f3 100644
--- a/config/routes.rb
+++ b/config/routes.rb
@@ -2,6 +2,18 @@ Shiny::Application.routes.draw do
   # The priority is based upon order of creation:
   # first created -> highest priority.
 
+  resource :account, :only => [:edit, :update]
+
+  devise_for :users
+
+  namespace :admin do
+    resources :users
+  end
+
+  resources :contents
+  match ':id' => 'contents#display', :as => :display_content
+  root :to => 'contents#display'
+
   # Sample of regular route:
   #   match 'products/:id' => 'catalog#view'
   # Keep in mind you can assign values other than :controller and :action
