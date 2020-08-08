# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email
    first_name { |user| user.email.present? ? user.email.match(/(.*)@/)[1].titleize : %w[Manny Moe Jack].sample }
    last_name { 'Jones' }
    password { 'testing1' }
    time_zone { 'Eastern Time (US & Canada)' }
    confirmed_at { ::Time.current }
    country_code { 'US' }
    company_name { 'Princeton-Plainsboro Teaching Hospital (PPTH)' }
    address_line_1 do
      num = rand(100..999)
      name = %w[Maple Oak Hickory Apple Ash Beech Cedar Cypress].sample
      suffix = %w[St Ave Rd Dr].sample
      "#{num} #{name} #{suffix}"
    end
    city { %w[Goshen Auburn Bluffton Butler Clinton Columbus Decatur Elkhart Gary Indianapolis Greensburg].sample }
    postal_code { rand(10_000..99_998).to_s }
    state_code { |i| i.country.state_codes.sample }
    phone_number { '123-456-7890' }
  end

  factory :admin_user, parent: :user do
    roles { ['admin'] }
  end
end
