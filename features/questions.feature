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
    When I send a GET request to "questions/0b687481-322e-4276-8cfa-7dced7c3d552"
    Then the response status should be "200"
    And the JSON response should have "$.body" with the text "Quo vadis?"

  Scenario: Question can be deleted
    When I send a DELETE request to "/questions/137cc9de-d29b-4051-8031-f8fd539c28ba"
    Then the response status should be "200"
    And the JSON response should have "$.message" with the text "Question successfully deleted."
    When I send a GET request to "/questions/137cc9de-d29b-4051-8031-f8fd539c28ba"
    Then the response status should be "404"
    When I send a DELETE request to "/questions/137cc9de-d29b-4051-8031-f8fd539c28ba"
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

Scenario: A question cannot be created with a blank title or blank body
    When I send a POST request to "/questions" with the following:
    """
    {
      "title": "",
      "body": ""
    }
    """
    Then the response status should be "400"
    And the JSON response should not have "$.title" with the text ""
    And the JSON response should not have "$.body" with the text ""

  Scenario: An existing question can be updated
    When I send a PUT request to "/questions/b10d484b-33cd-423b-88d1-92b9cfc9259c" with the following:
    """
    {
      "title": "Cuatro"
    }
    """
    Then the response status should be "200"
    And the JSON response should have "$.message" with the text "Question successfully updated."

  Scenario: If a question is not found during update, return a not found status
    When I send a PUT request to "/questions/99999999-9999-9999-9999-999999999990" with the following:
    """
    {
      "title": "A fine example"
    }
    """
    Then the response status should be "404"

  Scenario: An existing question cannot be updated with a blank title
    When I send a PUT request to "questions/137cc9de-d29b-4051-8031-f8fd539c28ba" with the following:
    """
    {
      "body": ""
    }
    """
    Then the response status should be "400"
    When I send a GET request to "questions/137cc9de-d29b-4051-8031-f8fd539c28ba"
    And the JSON response should have "$.body" with the text "Filler"
