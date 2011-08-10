Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.define :user do |f|
  f.email { Factory.next :email }
  f.first_name {|user| user.email.present? ? user.email.match(/(.*)@/)[1].titleize : %w{Manny Moe Jack}.sample}
  f.last_name "Jones"
  f.password "testing"
  f.time_zone "Eastern Time (US & Canada)"
  f.confirmed_at 3.days.ago
  f.country_code "US"
  f.company_name "Princeton‑Plainsboro Teaching Hospital (PPTH)"
  f.address_line_1 { "#{rand(900) + 100} #{%w(Maple Oak Hickory Apple Ash Beech Cedar Cypress).sample} #{%w(St Ave Rd Dr).sample}" }
  f.city { %w(Goshen Auburn Bluffton Butler Clinton Columbus Decatur Elkhart Gary Indianapolis Greensburg).sample }
  f.postal_code { "#{rand(89999) + 10000}" }
  f.state_code {|i| i.country.state_codes.sample }
  f.phone_number {'123-456-7890'}
end

Factory.define :admin_user, :parent => :user do |f|
  f.roles { |user| [ Role.find_by_title('admin') ] }
end
