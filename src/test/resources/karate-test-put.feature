@REQ_HU-001
Feature: Test de API para métodos PUT

  @id:1 @actualizarPersonajeExitoso
  Scenario: T-API-HU-001-CA7-Actualizar personaje (exitoso)
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/1392'
    And def character = read('classpath:../data/put/successful-update.json')
    And request character
    When method PUT
    Then status 200
    And print response

  @id:2 @actualizarPersonajeNoExiste
  Scenario: T-API-HU-001-CA8-Actualizar personaje (no existe)
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/123456789'
    And def character = read('classpath:../data/put/successful-update.json')
    And request character
    When method PUT
    Then status 404
    And print response
    And match response.error == "Character not found"