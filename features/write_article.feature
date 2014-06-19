Feature: Write Articles
  As a blog administrator
  In order to share my thoughts with the world
  I want to be able to add articles to my blog

  Background:
    Given the blog is set up
    And I am logged into the admin panel

  @ok
  Scenario: Successfully write articles
    Given I am on the new article page
    When I create a new article
    Then I should be on the admin content page
    And the article should be created
