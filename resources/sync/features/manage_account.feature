Feature: User edits their account.
  As a user
  I want to edit my account
  So I can change my email, and password.

  Scenario: happy
    Given I am signed in as "alice@example.com/testing"
      And I am on the account page
    When I follow "Edit"
      And I fill in "Email" with "alicia@example.com"
      And I fill in "Password" with "soooper"
      And I fill in "Confirmation" with "soooper"
      And I press "Update"
    Then I should be on the account page
      And I should see "Account updated!"
      And I should see "alicia@example.com"
      And the password for "alicia@example.com" should be "soooper"

  Scenario: no password change
    Given I am signed in as "alice@example.com/testing"
      And I am on the account page
    When I follow "Edit"
      And I fill in "Email" with "alicia@example.com"
      And I press "Update"
    Then I should be on the account page
      And I should see "Account updated!"
      And I should see "alicia@example.com"
      And the password for "alicia@example.com" should be "testing"

  Scenario: empty
    Given I am signed in as "alice@example.com/testing"
      And I am on the account page
    When I follow "Edit"
      And I fill in "Email" with "alicia"
      And I fill in "Password" with ""
      And I fill in "Confirmation" with ""
      And I press "Update"
    Then I should be on the account page
      And I should see "error prohibited this account from being saved:"
      And the password for "alice@example.com" should be "testing"

  Scenario: success
    Given I am signed in as "alice@example.com/testing"
      And I am on the account page
    When I follow "Sign Out"
    Then I should be on the signin page
    And I should see "Sign Out successful!"

  Scenario: user deactivates account
    Given I am signed in
    And I am on the account page
    When I press "Cancel My Account"
    Then I should be on the new account page
    And I should see "Account canceled. We're sorry to see you go."
