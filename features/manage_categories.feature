Feature: Manage categories
  As an admin
  In order to categorize the articles in the blog
  I want to manage categories

  Background:
    Given the blog is set up
    And I am logged into the admin panel
    When I follow "Categories"

  @ok
  Scenario: Create new category
    When I create a new category
    Then I should be on the new category page
    And I should see the category on categories table

  @ok
  Scenario: Edit category
    When I change the name of an existing category
    Then I should be on the new category page
    And I should see the updated name of the category on categories table
