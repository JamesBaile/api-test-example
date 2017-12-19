@score @customer-storage-get
Feature: Getting an enquiry

  Scenario: I try to get an existing customer
    Given I set body to {"name":"Compare The Market", "customerId" : "my-id"}
     When I GET /customer?customerid=my-id
    Then response code should be 200

  Scenario: I try to get a non-existent customer
   When I GET /customer?customerid=unknown
    Then response code should be 404