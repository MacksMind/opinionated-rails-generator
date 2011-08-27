Feature: Manage contents
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Register new content
    Given I am signed in as an admin
    And I am on the new admin content page
    When I fill in "Name" with "name 1"
    And I fill in "Title" with "title 1"
    And I fill in "Html" with "html 1"
    And I press "Create"
    Then I should see "name 1"
    And I should see "title 1"
    And I should see "html 1"

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
