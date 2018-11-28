@core @customer-storage-post

Feature:
  Scenario: I can save an customer
    Given I pipe contents of file ./payload/customer.json to body
    And I set Content-Type header to application/json
    When I POST to /customer
    Then response code should be 201

  Scenario: Saving an invalid customer should result in a BadRequest response
    Given I pipe contents of file ./payload/invalid-customer.json to body
    And I set Content-Type header to application/json
    When I POST to /customer
    Then response code should be 400