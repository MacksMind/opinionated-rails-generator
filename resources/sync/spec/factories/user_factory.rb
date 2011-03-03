Factory.define :user do |u|
  u.sequence(:email) {|n| "user#{n}@example.com" }
  u.first_name {|user| user.email.match(/(.*)@/)[1].titleize }
  u.last_name "Jones"
  u.password "testing"
  u.password_confirmation {|u| u.password}
  u.time_zone "Eastern Time (US & Canada)"
  u.confirmed_at 3.days.ago
end

Factory.define :admin_user, :parent => :user do |a|
  a.roles { |user|
    [
      Factory(:role, :title => 'admin')
    ]
  }
end
