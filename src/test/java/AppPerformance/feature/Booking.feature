Feature: Tests for the 'booking' endpoint

Background: Define URL
    * def dataGen = Java.type('helpers.DataGenerator')
    Given url apiUrl
        And path 'booking'
    
    @parallel=false
    Scenario: Get all bookings
        When method Get
        Then status 200
            And match response == "#[2]"
            And match each response == bookingResponseSchema
    
    Scenario: Get existing booking by id
        *  def id = 1
        Given path id
        When method Get
        Then status 200
            And match response == {"date": "2022-02-01","destination": "MAD","id": 1,"origin": "WRO","userId": 1}
            And match response == bookingResponseSchema
        
    Scenario: Get booking of unexisting user
        * def id = 100
        Given path id
        When method Get
        Then status 404
            And match response == errorResponseSchema
            And match response contains {message:#("No booking with id "+id)}

    Scenario: Create a booking
    * def randomOrigin = dataGen.getRandomIataOrigin()
    * def randomDestination = dataGen.getRandomIataDestination()
    * def randomDate = dataGen.getRandomDate()
    Given request 
    """
        {
            "date": #(randomDate),
            "destination": #(randomDestination),
            "origin": #(randomOrigin),
            "userId": 1
        }
    """
    When method Post
    Then status 201
        And match response == bookingResponseSchema
    
    Scenario Outline: Cannot create booking without required property
        * def randomOrigin = dataGen.getRandomIataOrigin()
        * def randomDate = dataGen.getRandomDate()
        Given request <request>
        When method Post
        Then status 400
            And match response == errorResponseSchema
            And match response.message contains "Validation errors"
            And match response.errors[0].message contains <message>

        Examples:
        | message                                       | request
        | "must have required property 'destination'"   | {"date": #(randomDate),"origin": #(randomOrigin),"userId": 1}                             |
        | "must have required property 'origin'"        | {"date": #(randomDate),"destination": #(randomDestination), "userId": 1}                  |
        | "must have required property 'date'"          | {"destination": #(randomDestination), "origin": #(randomOrigin), "userId": 1}             |
        | "must have required property 'userId'"        | {"date": #(randomDate),"destination": #(randomDestination), "origin": #(randomOrigin)}    |

    Scenario Outline: Cannot create a booking with invalid IATA Code
        * def randomDestination = dataGen.getRandomIataDestination()
        * def randomDate = dataGen.getRandomDate()
        Given request 
        """
            {
                "date": #(randomDate),
                "destination": <destination>,
                "origin": <origin>,
                "userId": 1
            }
        """
        When method Post
        Then status 400
            And match response == errorResponseSchema
            And match response.message contains "Validation errors"
            And match response.errors[0].location contains {path: <path>}
            And match response.errors[0].message contains 'must match pattern "^[A-Z]{3}$"'
    
    Examples:
    | path              | origin            | destination           |
    | "/origin"         | "PORTO"           | #(randomDestination)  |
    | "/destination"    | #(randomOrigin)   | "LISBON"              |