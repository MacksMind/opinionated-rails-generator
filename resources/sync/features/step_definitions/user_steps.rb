# frozen_string_literal: true

Given /^the following users:$/ do |users|
  users.hashes.each do |user|
    FactoryBot.create(:user, user)
  end
end

When /^I delete the (\d+)(?:st|nd|rd|th) user$/ do |pos|
  visit admin_users_path
  within("table > tr:nth-child(#{pos.to_i + 1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following users:$/ do |expected_users_table|
  actual_table = find("table").all("tr").map { |row| row.all("th,td")[0..2].map { |cell| cell.text.strip } }
  expected_users_table.map_column!("Name") { |n| n || "" }
  expected_users_table.map_column!("Roles") { |r| r || "" }
  expected_users_table.diff!(actual_table)
end
