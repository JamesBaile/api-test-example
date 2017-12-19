@core @customer-storage-post

Feature:
  Scenario: I can save an customer
    Given I set body to {"name":"Compare The Market", "customerI" : "test-id" }
    When I POST to /customer
    Then response code should be 201

    Scenario Outline: Saving an invalid customer should result in a BadRequest response
    Given I set body to {}
    When I POST to /customer
    Then response code should be 400