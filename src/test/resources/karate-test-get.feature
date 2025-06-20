Feature: Test de API para métodos GET

  Scenario: T-API-HU-0001-CA1-Obtener todos los personajes
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    When method get
    Then status 200
    And print response

  Scenario: T-API-HU-0001-CA2-Obtener personaje por ID (exitoso)
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/30'
    When method get
    Then status 200
    And match response.id == 30
    And print response

  Scenario: T-API-HU-0001-CA3-Obtener personaje por ID (no existe)
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/999'
    When method get
    Then status 404
    And match response.error == "Character not found"
    And print response