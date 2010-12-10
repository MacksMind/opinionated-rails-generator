diff --git a/config/routes.rb b/config/routes.rb
index 0adb94d..e8a32e7 100644
--- a/config/routes.rb
+++ b/config/routes.rb
@@ -1,4 +1,17 @@
 Shiny::Application.routes.draw do
+  resources :foos
+
+  resources :users
+  resources :roles
+  match 'signin'  => 'user_sessions#new'
+  match 'signout' => 'user_sessions#destroy'
+  resource :user_session, :only => [:create]
+  resource :account, :except => :destroy do
+    resources :confirmations, :only => [:new, :create, :edit]
+    resources :password_resets, :only => [:new, :create, :edit, :update]
+  end
+  root :to => "accounts#show"
+
   # The priority is based upon order of creation:
   # first created -> highest priority.
 
