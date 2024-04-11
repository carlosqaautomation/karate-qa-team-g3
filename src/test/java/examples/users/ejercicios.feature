Feature: Ejercicios Clase 02

  Scenario: Caso 1 - Consultar usuario por id
    Given url "https://reqres.in"
    And path "/api/users/2"
    When method get
    Then status 200

  Scenario: Caso 2 - Consultar usuario por id
    * def id = 1
    Given url "https://reqres.in"
    And path "/api/users/" + id
    When method get
    Then status 200
    * print response

  Scenario: Caso 3 - Consultar usuario por id
    * def id = 4
    Given url "https://reqres.in"
    And path "/api/users/" + id
    When method get
    Then status 200
    And match response.data.id == id
    * print response.data.last_name

  Scenario: Caso 4 - Registrar usuario
    Given url "https://reqres.in"
    And path "/api/register"
    And request { "email": "eve.holt@reqres.in","password": "pistol" }
    When method post
    Then status 200

  Scenario Outline: Caso 5 - Registrar usuario
    * def body = { "email": <email>,"password": <password> }
    Given url "https://reqres.in"
    And path "/api/register"
    And request body
    When method post
    Then status 200
    And match response.id == '#notnull'

    Examples:
      | email              | password |
      | eve.holt@reqres.in | pistol   |

  Scenario Outline: Caso 6 - Registrar usuario
    * def body =
      """
        {
          "email": <email>,
          "password": <password>
        }
      """
    Given url "https://reqres.in"
    And path "/api/register"
    And request body
    When method post
    Then status 200
    And match response.id == '#notnull'

    Examples:
      | email              | password |
      | eve.holt@reqres.in | pistol   |