diff --git a/db/seeds.rb b/db/seeds.rb
index bc25fce..61aea48 100644
--- a/db/seeds.rb
+++ b/db/seeds.rb
@@ -5,3 +5,22 @@
 #
 #   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
 #   Character.create(name: "Luke", movie: movies.first)
+
+user = User.new(
+  email: 'mack@agilereasoning.com',
+  password: 'change_before_deploy',
+  first_name: 'Mack',
+  last_name: 'Earnhardt',
+  time_zone: 'Eastern Time (US & Canada)',
+  company_name: 'Agile Reasoning',
+  phone_number: '+1 317.286.6610',
+  address_line_1: '12175 Visionary Way Ste 610',
+  city: 'Fishers',
+  state_code: 'IN',
+  postal_code: '46038',
+  country_code: 'US',
+)
+
+user.roles = User::ROLES
+user.skip_confirmation!
+user.save!
