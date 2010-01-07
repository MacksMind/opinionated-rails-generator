Feature: Manage users
  In order to maintain users
  An admin
  wants a maintenance screen
  
  Scenario: Register new user
    Given I am signed in as an admin
      And the following users:
        |name|
        |Manny|
        |Moe|
        |Jack|
      And I am on the new user page
    When I fill in "Email" with "new_user@example.com"
      And I fill in "Name" with "Joe Blow"
      And I fill in "Password" with "asecret"
      And I fill in "Password confirmation" with "asecret"
      And I check "user_role_admin"
      And I press "Create"
    Then I should see "new_user@example.com"
      And I should see "Joe Blow"
      And I should see "admin"
    When I follow "Edit"
      And I fill in "Name" with "Jane Doe"
      And I press "Update"
    Then I should see "Jane Doe"

  Scenario: Delete user
    Given I am signed in as an admin
    And the following users:
      |id|email|name|
      |2|email_1@example.com|Alpha|
      |3|email_2@example.com|Bravo|
      |4|email_3@example.com|Charlie|
      |5|email_4@example.com|Delta|
    When I delete the 2rd user
    Then I should see the following users:
      |Email|Name|Roles|
      |insider@example.com|Insider|admin|
      |email_2@example.com|Bravo||
      |email_3@example.com|Charlie||
      |email_4@example.com|Delta||
