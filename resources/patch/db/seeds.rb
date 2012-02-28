diff --git a/db/seeds.rb b/db/seeds.rb
index 4edb1e8..d4e0795 100644
--- a/db/seeds.rb
+++ b/db/seeds.rb
@@ -5,3 +5,33 @@
 #
 #   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
 #   Mayor.create(name: 'Emanuel', city: cities.first)
+
+user = User.new(
+  :email => 'mack@agilereasoning.com',
+  :password => 'foobar',
+  :first_name => 'Mack',
+  :last_name => 'Earnhardt',
+  :time_zone => 'Eastern Time (US & Canada)',
+  :company_name => 'Agile Reasoning LLC',
+  :phone_number => '888-AGILE-2.0',
+  :address_line_1 => '1003 E 106th St',
+  :city => 'Indianapolis',
+  :state_code => 'IN',
+  :postal_code => '46280',
+  :country_code => 'US'
+)
+
+user.roles = User::ROLES
+user.save!
+
+Content.create!(
+  :name => 'Home',
+  :title => Baseline::AppName,
+  :html => "<h2>Welcome to #{Baseline::AppName}</h2>"
+)
+
+Content.create!(
+  :name => 'My Account',
+  :title => 'n/a',
+  :html => "=redirect_to edit_account_path"
+)
