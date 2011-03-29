diff --git a/config/routes.rb b/config/routes.rb
index 0adb94d..206af44 100644
--- a/config/routes.rb
+++ b/config/routes.rb
@@ -2,6 +2,24 @@ Shiny::Application.routes.draw do
   # The priority is based upon order of creation:
   # first created -> highest priority.
 
+  resources :roles
+  resources :users do
+    resource :password, :only => [:create, :edit, :update]
+  end
+  
+  resources :passwords, :only => [:new, :create]
+  resource :session, :only => [:new, :create, :destroy]
+
+  match 'sign_up'   => 'accounts#new'
+  match 'sign_in'   => 'sessions#new'
+  match 'sign_out'  => 'sessions#destroy', :via => :delete
+
+  resource :account do
+    resources :confirmations, :only => [:new, :create, :edit]
+  end
+
+  root :to => "accounts#new"
+
   # Sample of regular route:
   #   match 'products/:id' => 'catalog#view'
   # Keep in mind you can assign values other than :controller and :action
