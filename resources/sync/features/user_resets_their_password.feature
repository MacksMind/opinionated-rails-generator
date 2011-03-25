Feature: User resets their password.
  As a user who has forgotten my password
  I want to reset my password
  So I can sign in even with my faulty memory.

  Scenario: happy
    Given I am signed up as "alice@example.com/forgot"
    When I go to my edit password reset page
      And I fill in "user[password]" with "twiddle dee"
      And I fill in "user[password_confirmation]" with "twiddle dee"
      And I press "Update my password and sign me in"
    Then I should be on the account page
      And I should see "Password successfully updated"
      And the password for "alice@example.com" should be "twiddle dee"

  Scenario: mismatched password
    Given I am signed up as "alice@example.com/forgot"
    When I go to my edit password reset page
      And I fill in "user[password]" with "twiddle dee"
      And I fill in "user[password_confirmation]" with "twiddle dum"
      And I press "Update my password and sign me in"
    Then I should be on my password reset page
    And I should see "error prohibited this password change:"

  Scenario: bad token
    Given I am signed up as "alice@example.com/forgot"
    When I go to an invalid edit password reset page
    Then I should be on the new account password reset page
      And I should see /We're sorry, but that link is invalid or expired. Please try again./
