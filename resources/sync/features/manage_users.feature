Feature: Manage users
  In order to maintain users
  An admin
  wants a maintenance screen

  Scenario: Delete user
    Given the following users:
      |id|email|first_name|
      |2|email_1@example.com|Alpha|
      |3|email_2@example.com|Bravo|
      |4|email_3@example.com|Charlie|
      |5|email_4@example.com|Delta|
    And I am signed in as an admin
    When I delete the 2nd user
    Then I should see the following users:
      |Email|Name|Roles|
      |email_1@example.com|Alpha Jones||
      |email_3@example.com|Charlie Jones||
      |email_4@example.com|Delta Jones||
      |insider@example.com|Insider Jones|admin|
