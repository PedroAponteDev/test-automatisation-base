@REQ_HU-001
Feature: Test de API para métodos POST

  @id:1 @crearPersonajeExitoso
  Scenario: T-API-HU-001-CA4-Crear personaje (exitoso)
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    And def character = read('classpath:../data/post/successful-creation.json')
    And request character
    When method POST
    Then status 201
    And print response
    And match response.name == "Iron Man Pedro"
    And match response.alterego == "Genius billionaire"
    And match response.description == "Tony Stark"

  @id:2 @crearPersonajeNombreDuplicado
  Scenario: T-API-HU-001-CA5-Crear personaje (nombre duplicado)
    * header content-type = 'application/json'
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    And def character = read('classpath:../data/post/duplicate-name.json')
    And request character
    When method POST
    Then status 400
    And print response
    And match response.error == "Character name already exists"

    @id:3 @crearPersonajeFaltanCampos
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