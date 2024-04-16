Feature: Funcionalidade Users

  Background:
    * def responseLogin = call read("login.feature@login")
    * def token = responseLogin.authToken
    * url "https://reqres.in/"
    * header Authorization = "Bearer " + token

  Scenario: Caso 1
    Given path "/api/users"
    And request {"name": "morpheus","job": "leader"}
    When method post
    Then status 201

