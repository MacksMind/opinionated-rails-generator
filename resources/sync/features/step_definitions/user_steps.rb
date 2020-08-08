# frozen_string_literal: true

Given(/^the following users:$/) do |users|
  users.hashes.each do |user|
    FactoryBot.create(:user, user)
  end
end

When(/^I delete the (\d+)(?:st|nd|rd|th) user$/) do |pos|
  visit admin_users_path
  within("table > tbody > tr:nth-child(#{Integer(pos)})") do
    find("i[title='Destroy']").first(:xpath, './/..').click
  end
end

Then(/^I should see the following users:$/) do |expected_users_table|
  actual_table = find('table').all('tr').map { |row| row.all('th,td')[1..4].map { |cell| cell.text.strip } }
  # The last row displays pagination with colspan in order to scroll with the table on a mobile device
  actual_table = actual_table[0..-2]
  expected_users_table.diff!(actual_table)
end
