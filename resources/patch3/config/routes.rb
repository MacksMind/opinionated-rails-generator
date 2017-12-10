diff --git a/config/routes.rb b/config/routes.rb
index 0460ec1..c75ba07 100644
--- a/config/routes.rb
+++ b/config/routes.rb
@@ -1,5 +1,5 @@
 Rails.application.routes.draw do
-  devise_for :users
+  devise_for :users, controllers: { registrations: "users/registrations" }
   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 
   resource :account, only: [:edit, :update]
