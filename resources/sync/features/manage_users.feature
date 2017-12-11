Feature: Manage users
  In order to maintain users
  An admin
  wants a maintenance screen

  Scenario: Delete user
    Given the following users:
      |email|first_name|
      |email_1@example.com|Alpha|
      |email_2@example.com|Bravo|
      |email_3@example.com|Charlie|
      |email_4@example.com|Delta|
    And I am signed in as an admin
    When I delete the 2nd user
    Then I should see the following users:
      |Email|First name ▲|Last name ▲|Roles|
      |email_1@example.com|Alpha|Jones||
      |email_3@example.com|Charlie|Jones||
      |email_4@example.com|Delta|Jones||
      |insider@example.com|Insider|Jones|admin|
