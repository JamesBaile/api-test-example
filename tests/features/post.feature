@core @customer-storage-post

Feature:
  Scenario: I can save an customer
  #  Given I store the raw value {"key":"hello-world"} as myPayload in scenario scope
		# Given I set body to {"key":"hello-world"}
    Given I set body to {"name":"Compare The Market", "customerId" : "test-id" }
    When I POST to /customer
    Then response code should be 201

  Scenario: Saving an invalid customer should result in a BadRequest response
    Given I set body to {}
    When I POST to /customer
    Then response code should be 400