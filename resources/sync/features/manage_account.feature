Feature: User edits their account.
  As a user
  I want to edit my account
  So I can change my email, and password.

  Scenario: happy
    Given I am signed in as "alice@example.com/testing"
    When I go to the edit user registration page
    And I fill in "Email" with "alicia@example.com"
    And I fill in "Password" with "soooper"
    And I fill in "Password confirmation" with "soooper"
    And I fill in "Current password" with "testing"
    And I press "Update"
    Then I should be on the home page
    And I should see "You updated your account successfully."
    And I should see "alicia@example.com"
    And the password for "alicia@example.com" should be "soooper"

  Scenario: no password change
    Given I am signed in as "alice@example.com/testing"
    When I go to the edit user registration page
    And I fill in "Email" with "alicia@example.com"
    And I fill in "Current password" with "testing"
    And I press "Update"
    Then I should be on the home page
    And I should see "You updated your account successfully."
    And I should see "alicia@example.com"
    And the password for "alicia@example.com" should be "testing"

  Scenario: empty
    Given I am signed in as "alice@example.com/testing"
    When I go to the edit user registration page
    And I fill in "Email" with "alicia"
    And I fill in "Password" with ""
    And I press "Update"
    Then I should be on the user registration page
    And I should see error messages
    And the password for "alice@example.com" should be "testing"

  Scenario: success
    Given I am signed in as "alice@example.com/testing"
    And I am on the home page
    When I follow "Sign out"
    Then I should be on the home page
    And I should see "Signed out successfully."

  Scenario: user deactivates account
    Given I sign in
    And I am on the edit user registration page
    When I follow "Cancel my account"
    Then I should be on the home page
    And I should see "Bye! Your account was successfully cancelled. We hope to see you again soon."
