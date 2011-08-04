Given /^the following contents:$/ do |contents|
  Content.delete_all
  contents.hashes.each do |content|
    Factory(:content,content)
  end
end

When /^I delete the (\d+)(?:st|nd|rd|th) content$/ do |pos|
  visit contents_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following contents:$/ do |expected_contents_table|
  expected_contents_table.diff!(tableish('table tr', 'td,th'))
end
