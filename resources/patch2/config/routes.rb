diff --git a/config/routes.rb b/config/routes.rb
index 262ffd5..2b6c10f 100644
--- a/config/routes.rb
+++ b/config/routes.rb
@@ -1,6 +1,20 @@
 Rails.application.routes.draw do
   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
 
+  resource :account, only: %i[edit update]
+
+  namespace :admin do
+    resources :users do
+      member do
+        post :masquerade
+      end
+    end
+  end
+
+  resources :dashboard, only: [:index]
+
+  get 'avatar/name/:full_name', to: 'avatar#name', as: :avatar_name
+
   # Defines the root path route ("/")
-  # root "articles#index"
+  root 'dashboard#welcome'
 end
