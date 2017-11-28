Feature:
  I want to verify that the service is operational

  #Happy path

  Scenario: I want to check that the server returns a 200
    When I GET /health
    Then response code should be 200

  Scenario: I want to check that the server returns a 400 if an unexpected url is called
    When I GET /health/foo
    Then response code should be 404

  Scenario: I want to check service name
    When I GET /health
    Then response body path $.serviceName should be api-test

  Scenario: I want to check isOk returns true
    Given the service is operational
    When I GET /health
    Then response body path $.isOk should be true