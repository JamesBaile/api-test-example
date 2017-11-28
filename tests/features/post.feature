Feature:
  Scenario: I can save an enquiry
    When I save a valid customer
    Then response code should be 201

  Scenario: I want to save a new enquiry 
    Given I save a valid customer
    When I POST to /customer
    Then response code should be 201

    Scenario Outline: Saving an invalid customer should result in a BadRequest response
    Given I have a valid customer
    And I change <fieldUnderTest> to <invalidValue>
    When I POST to /enquiry
    Then response code should be 400

    Examples:
    | fieldUnderTest                     | invalidValue |
    | name                               |              |
    | name                               | null         |