Feature: Visitor signs up for an account.
  As a visitor
  I want to sign up for an account
  So that I sign in.

  Scenario: Visitor can register
    Given I am on the signin page
    When I follow "Sign Up"
      And I fill in "Email" with "jq@example.com"
      And I fill in "Name" with "John"
      And I select "(GMT-05:00) Eastern Time (US & Canada)" from "Time zone"
      And I fill in "Password" with "humpty dumpty"
      And I fill in "Password Confirmation" with "humpty dumpty"
      And I press "Sign Up"
    Then jq@example.com should receive an email
      And I should be on the signin page
      And I should see "Instructions to confirm your account have been emailed to you. Please check your email."

  Scenario: Visitor can confirm account
    Given the unconfirmed user "alice@example.com/testing"
    When I go to my account confirmation page
    Then I should be on the homepage
      And I should see "Account Confirmed"

  Scenario: Account cannot be confirmed twice
    Given the user "alice@example.com/testing"
    When I go to my account confirmation page
    Then I should be on the new account page
      And I should see "That account has already been confirmed!"

  Scenario: Visitor can resend confirmation message
    Given the unconfirmed user "alice@example.com/testing"
    When I go to an invalid account confirmation page
    Then I should be on the new account confirmation page
      And I should see "We're sorry, but that link is invalid or expired. You must complete the Account Confirmation process within 4 hours. Please try again."
    When I fill in "email" with "alice@example.com"
      And I press "Resend Confirmation"
    Then alice@example.com should receive an email
      And I should be on the signin page
      And I should see "Instructions to confirm your account have been emailed to you. Please check your email."

  Scenario: Visitor has a link to resend confirmation if lost
    Given I am on the signin page
    When I follow "Resend Confirmation"
    Then I should be on the new account confirmation page

  Scenario: Visitor receives an appropriate message for invalid email
    Given I am on the new account confirmation page
    When I fill in "email" with "malory@example.com"
      And I press "Resend Confirmation"
    Then I should be on the account confirmations page
      And I should see "No user was found with that email address"

  Scenario: missing field
    Given I am on the signin page
    When I follow "Sign Up"
      And I fill in "Password" with "humpty dumpty"
      And I fill in "Password Confirmation" with "humpty dumpty"
      And I press "Sign Up"
    Then I should be on the account page
      And I should see "There were problems"

  Scenario: signed in user can't use register page
    Given I am signed in as "alice@example.com/testing"
    When I go to the new account page
    Then I should see "You must be signed out to access this page"
      And I am on the account page

  Scenario: success
    Given the user "alice@example.com/testing"
    When I go to the signin page
      And I fill in "Email" with "alice@example.com"
      And I fill in "Password" with "testing"
      And I press "Sign In"
    Then I should be on the account page
      And I should see "Sign In successful!"

  Scenario: failure
    Given the user "alice@example.com/testing"
    When I go to the signin page
      And I fill in "Email" with "alice@example.com"
      And I fill in "Password" with "bah"
      And I press "Sign In"
    Then I should be on the user session page
      And I should see "Password is not valid"
