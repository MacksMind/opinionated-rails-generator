diff --git a/db/seeds.rb b/db/seeds.rb
index 1beea2a..3ddd677 100644
--- a/db/seeds.rb
+++ b/db/seeds.rb
@@ -5,3 +5,22 @@
 #
 #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
 #   Character.create(name: 'Luke', movie: movies.first)
+
+user = User.new(
+  email: "mack@agilereasoning.com",
+  password: "foobarbaz",
+  first_name: "Mack",
+  last_name: "Earnhardt",
+  time_zone: "Eastern Time (US & Canada)",
+  company_name: "Agile Reasoning LLC",
+  phone_number: "888-AGILE-2.0",
+  address_line_1: "PO Box 274",
+  city: "Carmel",
+  state_code: "IN",
+  postal_code: "46082",
+  country_code: "US"
+)
+
+user.roles = User::ROLES
+user.skip_confirmation!
+user.save!
