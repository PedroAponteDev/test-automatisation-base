@REQ_HU-0001
Feature: Test de API para métodos GET

  @id:1 @obtenerPersonajes
  Scenario: T-API-HU-001-CA1-Obtener todos los personajes
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    When method get
    Then status 200
    And print response

  @id:2 @obtenerPersonajePorId
  Scenario: T-API-HU-001-CA2-Obtener personaje por ID (exitoso)
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

    # Paso 2: Obtener el personaje usando el ID generado
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/' + characterId
    When method GET
    Then status 200
    And match response.id == characterId
    And match response.name == "Iron Man Pedro"
    And print response

    # Paso 3: Eliminar el personaje usando el ID obtenido
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/' + characterId
    When method DELETE
    Then status 204
    And print response

  @id:3 @obtenerPersonajePorIdNoExiste
  Scenario: T-API-HU-001-CA3-Obtener personaje por ID (no existe)
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/123456789'
    When method get
    Then status 404
    And match response.error == "Character not found"
    And print response