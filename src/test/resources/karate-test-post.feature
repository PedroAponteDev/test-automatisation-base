@REQ_HU-001
Feature: Test de API para métodos POST

  @id:1 @crearPersonajeExitosoYValidarNombreDuplicado
  Scenario: T-API-HU-001-CA4-Crear personaje (exitoso) y validar nombre duplicado
    # Paso 1: Crear un personaje
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    And def character = read('classpath:../data/post/successful-creation.json')
    And request character
    When method POST
    Then status 201
    And print response
    And match response.name == "Iron Man Pedro"
    And match response.alterego == "Tony Stark"
    And match response.description == "Genius billionaire"
    * def characterId = response.id
    * print 'Personaje creado con ID:', characterId

    # Paso 2: Validar nombre duplicado
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    And def character = read('classpath:../data/post/duplicate-name.json')
    And request character
    When method POST
    Then status 400
    And print response
    And match response.error == "Character name already exists"

    # Paso 2: Eliminar el personaje usando el ID obtenido
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/' + characterId
    When method DELETE
    Then status 204
    And print response

  @id:2 @crearPersonajeFaltanCampos
  Scenario: T-API-HU-001-CA6-Crear personaje (faltan campos requeridos)
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    And def character = read('classpath:../data/post/missing-fields.json')
    And request character
    When method POST
    Then status 400
    And print response
    And match response.name == "Name is required"
    And match response.alterego == "Alterego is required"
    And match response.description == "Description is required"
    And match response.powers == "Powers are required"