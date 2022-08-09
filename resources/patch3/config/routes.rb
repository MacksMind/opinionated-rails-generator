diff --git a/config/routes.rb b/config/routes.rb
index 63623d0..fbe788c 100644
--- a/config/routes.rb
+++ b/config/routes.rb
@@ -1,5 +1,5 @@
 Rails.application.routes.draw do
-  devise_for :users
+  devise_for :users, controllers: { registrations: 'users/registrations' }
   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
 
   resource :account, only: %i[edit update]
