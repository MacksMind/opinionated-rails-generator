FactoryBot.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email
    first_name { |user| user.email.present? ? user.email.match(/(.*)@/)[1].titleize : %w{Manny Moe Jack}.sample }
    last_name "Jones"
    password "testing1"
    time_zone "Eastern Time (US & Canada)"
    country_code "US"
    company_name "Princeton-Plainsboro Teaching Hospital (PPTH)"
    address_line_1 { "#{rand(900) + 100} #{%w(Maple Oak Hickory Apple Ash Beech Cedar Cypress).sample} #{%w(St Ave Rd Dr).sample}" }
    city { %w(Goshen Auburn Bluffton Butler Clinton Columbus Decatur Elkhart Gary Indianapolis Greensburg).sample }
    postal_code { "#{rand(89999) + 10000}" }
    state_code { |i| i.country.state_codes.sample }
    phone_number '123-456-7890'
  end

  factory :admin_user, parent: :user do
    roles ["admin"]
  end
end
