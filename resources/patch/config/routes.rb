diff --git a/config/routes.rb b/config/routes.rb
index 0adb94d..bafead0 100644
--- a/config/routes.rb
+++ b/config/routes.rb
@@ -2,6 +2,17 @@ Shiny::Application.routes.draw do
   # The priority is based upon order of creation:
   # first created -> highest priority.
 
+  resources :users
+  resources :roles
+  match 'signin'  => 'user_sessions#new'
+  match 'signout' => 'user_sessions#destroy'
+  resource :user_session, :only => [:create]
+  resource :account do
+    resources :confirmations, :only => [:new, :create, :edit]
+    resources :password_resets, :only => [:new, :create, :edit, :update]
+  end
+  root :to => "accounts#new"
+
   # Sample of regular route:
   #   match 'products/:id' => 'catalog#view'
   # Keep in mind you can assign values other than :controller and :action
