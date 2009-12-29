Feature: User forgot their password.
  As a user
  I want to forget my password
  So I can use the app to send me an email with instructions on how to change it.

  Scenario: email exists
    Given the user "alice@example.com/testing"
      And I am on the signin page
    When I follow "Forgot password"
      And I fill in "email" with "alice@example.com"
      And I press "Reset my password"
    Then alice@example.com should receive an email
      And I should be on the signin page
      And I should see "Instructions to reset your password have been emailed to you. Please check your email."

  Scenario: email does not exist
    Given the user "alice@example.com/testing"
      And I am on the signin page
    When I follow "Forgot password"
      And I fill in "email" with "malory@example.com"
      And I press "Reset my password"
    Then I should be on the account password resets page
      And I should see "No user was found with that email address"
