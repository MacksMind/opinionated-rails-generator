diff --git a/app/models/user.rb b/app/models/user.rb
index 6271ae5..215448c 100644
--- a/app/models/user.rb
+++ b/app/models/user.rb
@@ -4,7 +4,8 @@ class User < ActiveRecord::Base
   # Include default devise modules. Others available are:
   # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
   devise :database_authenticatable, :registerable,
-         :recoverable, :rememberable, :validatable
+         :recoverable, :rememberable, :validatable,
+         :confirmable, :lockable, :trackable
   belongs_to :country, optional: true, primary_key: :code, foreign_key: :country_code, inverse_of: false
   belongs_to :state, optional: true
 
