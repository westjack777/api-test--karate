Feature: Tests for the 'user' endpoint

    Background: Define URL
        * def dataGen = Java.type('helpers.DataGenerator')
        Given url apiUrl
            And path 'user'

    @parallel=false
    Scenario: Get all users
        When method Get
        Then status 200
            And match response == "#[2]"
            And match each response == userResponseSchema
    
    Scenario: Get existing user by id
        *  def id = 1
        Given path id
        When method Get
        Then status 200
            And match response == {"email": "john.doe@wherever.com","id": 1, "name": "John","surname": "Doe"}
            And match response == userResponseSchema
    
    Scenario: Get user by unexisting id
        * def id = 100
        Given path id
        When method Get
        Then status 404
            And match response == errorResponseSchema
            And match response contains {message:#("No user with id "+id)}

    Scenario: Cannot create user with existing email
        Given request 
        """
            {
                "email": "john.doe@wherever.com",
                "name": "John",
                "surname": "Doe"
            }
        """    
        When method Post
        Then status 409
            And match response contains {message:"User with email 'john.doe@wherever.com' already exists"}
            And match response == errorResponseSchema
    
    Scenario: Create a random user
        * def randomName = dataGen.getRandomName()
        * def randomSurname = dataGen.getRandomSurname()
        * def randomEmail = dataGen.getRandomEmail()
        Given request 
        """
            {
                "email": #(randomEmail),
                "name": #(randomName),
                "surname": #(randomSurname)
            }
        """
        When method Post
        Then status 201
            And match response == {"email": #(randomEmail),"id": 3, "name": #(randomName),"surname": #(randomSurname)}
            And match response == userResponseSchema
        
    Scenario Outline: Cannot create user without required property
        * def randomName = dataGen.getRandomName()
        * def randomEmail = dataGen.getRandomEmail()
        Given request <request>
        When method Post
        Then status 400
            And match response == errorResponseSchema
            And match response.message contains "Validation errors"
            And match response.errors[0].message contains <message>
        
        Examples:
        | message                                   | request                                               |
        | "must have required property 'email'"     | {"name": #(randomName),"surname": #(randomSurname)}   |
        | "must have required property 'name'"      | {"email": #(randomEmail),"surname": #(randomSurname)} |
        | "must have required property 'surname'"   | {"email": #(randomEmail),"name": #(randomName)}       |