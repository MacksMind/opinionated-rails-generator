# General

Then /^I should see error messages$/ do
  Then %{I should see "errors prohibited"}
end

Then /^I should see an error message$/ do
  Then %{I should see "error prohibited"}
end

Then /^I should see an email field$/ do
  if page.respond_to?(:should)
    page.should have_css("input[type='email']")
  else
    assert page.has_css("input[type='email']")
  end
end

# Database

Given /^no user exists with an email of "(.*)"$/ do |email|
  assert_nil User.find_by_email(email)
end

Given /^(?:I am|I have|I) signed up (?:as|with) "(.*)\/(.*)"$/ do |email, password|
  Factory(:user,
          :email    => email,
          :password => password)
end

Given /^a user "([^"]*)" exists without a password$/ do |email|
  user = Factory(:user, :email => email)
  sql  = "update users set encrypted_password = '' where id = #{user.id}"
  ActiveRecord::Base.connection.update(sql)
end

# Session

Then /^I should be signed in$/ do
  Given %{I am on the homepage}
  Then %{I should see "Sign out"}
end

Then /^I should be signed out$/ do
  Given %{I am on the homepage}
  Then %{I should see "Remember me"}
end

When /^session is cleared$/ do
  # TODO: This doesn't work with Capybara
  # TODO: I tried Capybara.reset_sessions! but that didn't work
  #request.reset_session
  #controller.instance_variable_set(:@_current_user, nil)
end

Given /^(?:I am|I have|I) signed in (?:with|as) "(.*)\/(.*)"$/ do |email, password|
  Given %{I am signed up as "#{email}/#{password}"}
  And %{I sign in as "#{email}/#{password}"}
end

Given /^I sign in$/ do
  email = Factory.next(:email)
  Given %{I have signed in with "#{email}/password"}
end

# Emails

Then /^a password reset message should be sent to "(.*)"$/ do |email|
  user = User.find_by_email(email)
  assert !user.reset_password_token.blank?
  assert !ActionMailer::Base.deliveries.empty?
  result = ActionMailer::Base.deliveries.any? do |email|
    email.to      == [user.email] &&
    email.subject =~ /password/i &&
    email.body    =~ /#{user.reset_password_token}/
  end
  assert result
end

When /^I follow the password reset link sent to "(.*)"$/ do |email|
  user = User.find_by_email(email)
  visit edit_user_password_path(:reset_password_token   => user.reset_password_token)
end

# Actions

When /^I sign in (?:with|as) "(.*)\/(.*)"$/ do |email, password|
  When %{I go to the new user session page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I press "Sign in"}
end

When "I sign out" do
  steps %{
    When I go to the homepage
    And I follow "Sign out"
  }
end

When /^I request password reset link to be sent to "(.*)"$/ do |email|
  When %{I go to the new user password page}
  And %{I fill in "Email" with "#{email}"}
  And %{I press "Send me reset password instructions"}
end

When /^I update my password with "(.*)"$/ do |password|
  And %{I fill in "New password" with "#{password}"}
  And %{I fill in "Confirm new password" with "#{password}"}
  And %{I press "Change my password"}
end

When /^I return next time$/ do
  When %{session is cleared}
  And %{I go to the homepage}
end
