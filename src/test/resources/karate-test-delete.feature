@REQ_HU-001
Feature: Test de API para métodos DELETE

  @id:1 @eliminarPersonajeExitoso
  Scenario: T-API-HU-001-CA9-Eliminar personaje (exitoso)
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/1392'
    When method DELETE
    Then status 204
    And print response

  @id:2 @eliminarPersonajeNoExiste
  Scenario: T-API-HU-001-CA10-Eliminar personaje (no existe)
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/123456789'
    When method DELETE
    Then status 404
    And print response
    And match response.error == "Character not found"