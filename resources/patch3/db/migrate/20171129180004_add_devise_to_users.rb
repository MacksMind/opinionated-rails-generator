diff --git a/db/migrate/20171129180004_add_devise_to_users.rb b/db/migrate/20171129180004_add_devise_to_users.rb
index a668078..36345dd 100644
--- a/db/migrate/20171129180004_add_devise_to_users.rb
+++ b/db/migrate/20171129180004_add_devise_to_users.rb
@@ -22,15 +22,15 @@ class AddDeviseToUsers < ActiveRecord::Migration[5.1]
       t.inet     :last_sign_in_ip
 
       ## Confirmable
-      # t.string   :confirmation_token
-      # t.datetime :confirmed_at
-      # t.datetime :confirmation_sent_at
-      # t.string   :unconfirmed_email # Only if using reconfirmable
+      t.string   :confirmation_token
+      t.datetime :confirmed_at
+      t.datetime :confirmation_sent_at
+      t.string   :unconfirmed_email # Only if using reconfirmable
 
       ## Lockable
-      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
-      # t.string   :unlock_token # Only if unlock strategy is :email or :both
-      # t.datetime :locked_at
+      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
+      t.string   :unlock_token # Only if unlock strategy is :email or :both
+      t.datetime :locked_at
 
 
       # Uncomment below if timestamps were not included in your original model.
@@ -39,8 +39,8 @@ class AddDeviseToUsers < ActiveRecord::Migration[5.1]
 
     add_index :users, :email,                unique: true
     add_index :users, :reset_password_token, unique: true
-    # add_index :users, :confirmation_token,   unique: true
-    # add_index :users, :unlock_token,         unique: true
+    add_index :users, :confirmation_token,   unique: true
+    add_index :users, :unlock_token,         unique: true
   end
 
   def self.down
