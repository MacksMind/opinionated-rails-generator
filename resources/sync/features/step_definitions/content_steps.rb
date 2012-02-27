Given /^the following contents:$/ do |contents|
  Content.delete_all
  contents.hashes.each do |content|
    Factory(:content,content)
  end
end

When /^I delete the (\d+)(?:st|nd|rd|th) content$/ do |pos|
  visit admin_contents_path
  within("div#contents div.content:nth-child(#{pos.to_i})") do
    click_link "Destroy"
  end
end

Then /^I should see the following contents:$/ do |expected_contents_table|
  actual_table = find('div#contents').all('div.content').map { |row| row.all('div')[0..2].map { |cell| cell.text.strip } }
  expected_contents_table.diff!(actual_table)
end
