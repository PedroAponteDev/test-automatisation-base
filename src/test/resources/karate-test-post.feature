@REQ_HU-001
Feature: Test de API para métodos POST

  Scenario: T-API-HU-001-CA4-Crear personaje (exitoso)
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    And def character = read('classpath:../data/post/successful-creation.json')
    And request character
    When method POST
    Then status 201
    And print response

  Scenario: T-API-HU-001-CA5-Crear personaje (nombre duplicado)
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    And def character = read('classpath:../data/post/duplicate-name.json')
    And request character
    When method POST
    Then status 400
    And print response
    And match response.error == "Character name already exists"

  Scenario: T-API-HU-001-CA6-Crear personaje (faltan campos requeridos)
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    And def character = read('classpath:../data/post/missing-fields.json')
    And request character
    When method POST
    Then status 400
    And print response
    And match response.name == "Name is required"
    And match response.description == "Description is required"
    And match response.powers == "Powers are required"
    And match response.alterego == "Alterego is required"