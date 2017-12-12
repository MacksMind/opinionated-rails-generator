diff --git a/app/models/user.rb b/app/models/user.rb
index c51aace..1a12d4f 100644
--- a/app/models/user.rb
+++ b/app/models/user.rb
@@ -27,7 +27,9 @@ class User < ActiveRecord::Base
   # Include default devise modules. Others available are:
   # :confirmable, :lockable, :timeoutable and :omniauthable
   devise :database_authenticatable, :registerable,
-         :recoverable, :rememberable, :trackable, :validatable
+         :recoverable, :rememberable, :trackable, :validatable,
+         :confirmable
+
   belongs_to :country, optional: true, primary_key: :code, foreign_key: :country_code
   belongs_to :state, optional: true
 
