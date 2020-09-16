Feature: Answers API

  Background:
    Given I send and accept JSON

  Scenario: Answers can be found on a specific Question page
    Given "A Question With Many Answers" exists
    When I send a GET request to "questions/0b687481-322e-4276-8cfa-7dced7c3d552/answers"
    Then the response status should be "200"
    And the JSON response should have "$[0]body" with the text "One answer!"
    And the JSON response should have "$[1]body" with the text "A second answer!"
 
  Scenario: If a Question does not exist, neither can an Answer
    When I send a GET request to "questions/1234/answers"
    Then the response status should be "404"
    And the JSON response should have "$.message" with the text "Unable to find Question."

  Scenario: Answer can be deleted
    Given "A Question With An Answer To Delete" exists
    When I send a DELETE request to "/questions/dee0a0c2-e447-4a1e-a638-da53d3d70c60/answers/b96b6139-c9ee-4f8c-b667-c61a5e6daf8e"
    Then the response status should be "200"
    And the JSON response should have "$.message" with the text "Answer successfully deleted."
    When I send a GET request to "/questions/dee0a0c2-e447-4a1e-a638-da53d3d70c60/answers/b96b6139-c9ee-4f8c-b667-c61a5e6daf8e"
    Then the response status should be "404"
    When I send a DELETE request to "/questions/dee0a0c2-e447-4a1e-a638-da53d3d70c60/answers/b96b6139-c9ee-4f8c-b667-c61a5e6daf8e"
    Then the JSON response should have "$.error" with the text "Unable to delete Answer."
    And the response status should be "400"

  Scenario: A new answer can be created if a question exists
    Given "A Question With No Answer" exists
    When I send a GET request to "/questions/99999999-9999-9999-9999-999999999999"
    Then the response status should be "200"
    When I send a POST request to "/questions/99999999-9999-9999-9999-999999999999/answers" with the following:

    """
    {
      "body": "A new answer is created!",
      "question_id": "99999999-9999-9999-9999-999999999999"
    }
    """
    Then the response status should be "201"
    And the JSON response should have "$.body" with the text "A new answer is created!"
    When I send a GET request to "/questions/99999999-9999-9999-9999-999999999999/answers"
    Then the response status should be "200"
    And the JSON response should have "$[0]body" with the text "A new answer is created!"

  Scenario: An existing answer cannot be updated with a blank body
    Given "A Question With One Answer" exists 
    When I send a PUT request to "/questions/09999999-9999-9999-9999-999999999999/answers/99999999-9999-9999-9999-999999999990"
    """
    {
      "body": ""
    }
    """
    Then the response status should be "400"
    When I send a GET request to "/questions/09999999-9999-9999-9999-999999999999/answers/99999999-9999-9999-9999-999999999990"
    And the JSON response should have "$.body" with the text "The answer you've been waiting for"

  Scenario: An existing answer can be updated
    Given "A Question With One Answer" exists
    When I send a PUT request to "/questions/09999999-9999-9999-9999-999999999999/answers/99999999-9999-9999-9999-999999999990" with the following: 
    """
    {
      "body": "A new answer will expand your horizons"   
    }
    """
    Then the response status should be "200"
    And the JSON response should have "$.message" with the text "Answer successfully updated."
