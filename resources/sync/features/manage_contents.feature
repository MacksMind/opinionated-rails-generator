Feature: Manage contents
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Delete content
    Given I am signed in as an admin
    And the following contents:
      |name|title|html|
      |name 1|title 1|html 1|
      |name 2|title 2|html 2|
      |name 3|title 3|html 3|
      |name 4|title 4|html 4|
    When I delete the 3rd content
    Then I should see the following contents:
      |name 1|title 1|html 1|
      |name 2|title 2|html 2|
      |name 4|title 4|html 4|
