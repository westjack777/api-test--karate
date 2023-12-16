Feature: Test performance of the app

Background: Define URL
    * def dataGen = Java.type('helpers.DataGenerator')
    Given url apiUrl
        And path 'user'

    Scenario: Create random users
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
            And match response contains {"email": #(randomEmail), "name": #(randomName),"surname": #(randomSurname)}
            And match response == userResponseSchema