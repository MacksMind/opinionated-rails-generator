Given /^the following users:$/ do |users|
  users.hashes.each do |user|
    Factory(:user,user)
  end
end

Given /^I am signed in as an? (.*)$/ do |title|
  Given 'I am signed in as "insider@example.com/asecret"'
  role = Role.find_by_title(title) || Factory(:role, :title => title)
  @user.roles << role
end

Given /^I am signed in$/ do
  Given 'I am signed in as "alice@example.com/password"'
end

Given /^the user "(.*@.*)\/(.*)"$/ do |email, password|
  @user_email = email
  @user_password = password
  @user = User.find_by_email(email) || Factory(:user, :email => email, :password => password)
end

Given /^the unconfirmed user "(.*)"$/ do |userspec|
  Given "the user \"#{userspec}\""
  @user.update_attribute(:confirmed_at,nil)
end

Given /^I am signed in as "(.*)"$/ do |userspec|
  Given  "the user \"#{userspec}\""
  visit(signin_path)
  fill_in "Email", :with => @user_email
  fill_in "Password", :with => @user_password
  click_button 'Sign In'
end

Then /^my password should be "(.*)"$/ do |pass|
  Authlogic::Session::Base.controller ||= ApplicationController.new

  user = assigns(:current_user)
  # if the save failed we need the original email
  email = user.changed? ? user.email_was : user.email

  @session = UserSession.new(:email => email, :password => pass)
  @session.valid?.should be_true
end

When /^I delete the (\d+)(?:st|nd|rd|th) user$/ do |pos|
  visit users_url
  within("table > tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following users:$/ do |expected_users_table|
  expected_users_table.map_column!('Name') {|n| n || ""}
  expected_users_table.map_column!('Roles') {|r| r || ""}
  expected_users_table.diff!(table_at('table').to_a)
end

Then /^(.*@.*) should receive an email$/ do |email|
  ActionMailer::Base.deliveries.should_not be_empty
  ActionMailer::Base.deliveries.last.to.should include(email)
end
