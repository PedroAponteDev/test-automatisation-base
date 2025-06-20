@REQ_HU-001
Feature: Test de API para métodos DELETE

  @id:1 @crearYEliminarPersonajeExitoso
  Scenario: T-API-HU-001-CA4-CA9-Crear y eliminar personaje (exitoso)
    # Paso 1: Crear un personaje
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    And def character = read('classpath:../data/post/successful-creation.json')
    And request character
    When method POST
    Then status 201
    And print response
    * def characterId = response.id
    * print 'Personaje creado con ID:', characterId

    # Paso 2: Eliminar el personaje usando el ID obtenido
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/' + characterId
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