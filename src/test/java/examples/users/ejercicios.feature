@automation
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

  Scenario: Caso 7 - Actualizar Usuario
    Given url "https://reqres.in"
    And path "/api/users/2"
    And request {"name": "morpheus","job": "zion resident"}
    When method put
    Then status 200

  Scenario: Caso 10 - Actualizar
    * def id = 2
    Given url "https://reqres.in"
    And path "/api/users/" + id
    And form field name = "morpheus"
    And form field job = "zion resident"
    When method put
    Then status 200
    And match responseType == "json"
    And match $.name == "morpheus"
    And match $.job == "zion resident"

  Scenario: Caso 11 - Actualizar
    * def id = 2
    Given url "https://reqres.in"
    And path "/api/users/" + id
    And request read('body.json')
    When method put
    Then status 200
    And match responseType == "json"
    And match $.name == "morpheus"
    And match $.job == "zion resident"

  Scenario: Caso 12 - Buscar comentarios por postId
    Given url "https://jsonplaceholder.typicode.com"
    And path "/comments"
    And param postId = "1"
    When method get
    Then status 200

  @case13
  Scenario: Caso 13 - Crear un post con docString en variable
    * def body =
    """
    {
      'userId': 1,
      'title': 'Post de prueba',
      'body': 'Body de prueba'
    }
    """
    Given url "https://jsonplaceholder.typicode.com"
    And path "/posts"
    And request body
    When method post
    Then status 201
    * print response
    And match response.title == "Post de prueba"
    And match response.body == "Body de prueba"
    And match response.userId == 1

  Scenario: Caso 14 - Crear un post con docString en variable
    * def body =
    """
    {
      'userId': 1,
      'title': 'Post de prueba',
      'body': 'Body de prueba'
    }
    """
    Given url "https://jsonplaceholder.typicode.com"
    And path "/posts"
    And request body
    When method post
    Then status 201
    * print response
    And match response ==
    """
    {
      'id': #number,
      'userId': #number,
      'title': #string,
      'body': #string
    }
    """

    Scenario: Caso 15 - Crear un post con JSON en variable
      * def body =
      """
      {
        'userId': 1,
        'title': 'Post de prueba',
        'body': 'Body de prueba'
      }
      """
      Given url "https://jsonplaceholder.typicode.com"
      And path "/posts"
      And request body
      When method post
      Then status 201
      * print response
      And match response == read('estructura-response.json')