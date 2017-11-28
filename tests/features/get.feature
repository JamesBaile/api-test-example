@core @enquiry-storage-get
Feature: Getting an enquiry

  Scenario: I try to get an existing enquiry
    Given I save a valid customer
    When I retrieve that same customer
    Then response code should be 200

  Scenario: I try to get a non-existent enquiry
    When I try to get a non-existent enquiry
    Then response code should be 404

   Scenario: I try to get an existing enquiry
    Given I save a valid enquiry
    When I retrieve that same enquiry
    Then response code should be 200
    And response body path $.name should be CompareTheMarket