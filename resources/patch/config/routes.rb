diff --git a/config/routes.rb b/config/routes.rb
index 0adb94d..00d9e56 100644
--- a/config/routes.rb
+++ b/config/routes.rb
@@ -1,4 +1,17 @@
 Shiny::Application.routes.draw do
+
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
   # The priority is based upon order of creation:
   # first created -> highest priority.
 
