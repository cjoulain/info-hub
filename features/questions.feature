Feature: Questions API

  Background:
    Given I send and accept JSON
    And "First" exists
    And "Second" exists

  Scenario: Questions can be discovered on index page
    When I send a GET request to "/questions"
    Then the response status should be "200"
    And the JSON response should have "$[0]title" with the text "First question"
  
  Scenario: Question can be described through show action
    When I send a GET request to "questions/bb2361fe-ec6d-450b-90a2-03d90bbafbf7"
    Then the response status should be "200"
    And the JSON response should have "$.body" with the text "Quo vadis?"

  Scenario: Question can be deleted
    When I send a DELETE request to "/questions/bb2361fe-ec6d-450b-90a2-03d90bbafbf7"
    Then the response status should be "200"
    And the JSON response should have "$.message" with the text "Question successfully deleted."
    When I send a GET request to "/questions/bb2361fe-ec6d-450b-90a2-03d90bbafbf7"
    Then the response status should be "404"
    When I send a DELETE request to "/questions/bb2361fe-ec6d-450b-90a2-03d90bbafbf7"
    Then the JSON response should have "$.error" with the text "Unable to delete Question."
    And the response status should be "400"

  Scenario: A new question can be created
    When I send a POST request to "/questions" with the following:
    """
    {
      "title": "Triptych",
      "body": "Tercero!"
    }
    """
    Then the response status should be "201"
    And the JSON response should have "$.title" with the text "Triptych"
    And the JSON response should have "$.body" with the text "Tercero!"
    When I send a GET request to "/questions"
    Then the response status should be "200"
    And the JSON response should have "$[2].title" with the text "Triptych"

  Scenario: A question cannot be created with a blank title
    When I send a POST request to "/questions" with the following:
    """
    {
      "title": "",
      "body": ""
    }
    """
    Then the response status should be "400"
    And the JSON response should have "$.error" with the text "Title can't be blank","Body can't be blank"
