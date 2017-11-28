@mongo_is_down
Feature:
  As an Energy team member
  I want to verify that the service health remains functional when dependencies are not working

  #Sad Path
  Scenario: I want to check that the service returns a 200 when a dependency is down
    When I GET /health
    Then response code should be 200

  Scenario: I want to check that the MongoDB dependency is not ok
    When I GET /health
    Then response body path $.isOk should be false

Scenario: Saving a customer results in a FailedDependency response
    Given I save a valid customer
    When I POST to /customer
    Then response code should be 424