@REQ_HU-001
Feature: Test de API para métodos PUT

  @id:1 @actualizarPersonajeExitoso
  Scenario: T-API-HU-001-CA7-Actualizar personaje (exitoso)
    # Paso 1: Crear un personaje
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    And def createCharacter = read('classpath:../data/post/successful-creation.json')
    And request createCharacter
    When method POST
    Then status 201
    And print response
    * def characterId = response.id
    * print 'Personaje creado con ID:', characterId

    # Paso 2: Actualizar el personaje usando el ID obtenido
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/' + characterId
    And def character = read('classpath:../data/put/successful-update.json')
    And request character
    When method PUT
    Then status 200
    And print response
    And match response.name == "Iron Man Pedro"
    And match response.alterego == "Tony Stark"
    And match response.description == "Updated description"

    # Paso 3: Eliminar el personaje usando el ID obtenido
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/' + characterId
    When method DELETE
    Then status 204
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