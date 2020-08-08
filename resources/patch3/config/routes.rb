diff --git a/config/routes.rb b/config/routes.rb
index 4714f20..d7f173f 100644
--- a/config/routes.rb
+++ b/config/routes.rb
@@ -1,5 +1,5 @@
 Rails.application.routes.draw do
-  devise_for :users
+  devise_for :users, controllers: { registrations: 'users/registrations' }
   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 
   resource :account, only: %i[edit update]
