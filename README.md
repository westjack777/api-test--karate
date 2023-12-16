# qa-api-challenge
AppPerformance is an application that exposes a REST API.

It’s composed of two resources:
- user
- booking

It’s possible to create users and associate bookings with users.

## Instructions
- Install Docker
- Import app image to Docker like this: `docker load -i api_testing_service_latest.tar.xz`
- Start demo app like this: `docker run -d -p 8900:8900 --name apiservice api_testing_service`
- Swagger is available at http://127.0.0.1:8900/docs

## Requirements
- Please write automatic API tests for the resources exposed by the application (feel free to show us all your skills).
- Use any one of the following languages: Java (maven, junit), JavaScript or Python
- Provide documentation on how to run the tests
- Provide documentation explaining your choices regarding test framework and implemented tests
- Show reporting for your results

## Nice to have
- We are fans of BDD and Karate framework in Ryanair, use this if you can

-----
# How to run the API Tests
The following section contains instructions on how the run the API Tests

## Requirements
- JDK 8 (or above)
- Maven

## Running the tests
- Clone the repository 
```shell
$ git clone https://github.com/RyanairLabs/qa-api-challenge-westjack777.git
```
- Open the projected in your preffered IDE (VS Code is recommended)
- Run the tests using the script
```shell
$  mvn test -Dtest=AppPerformanceTest#testAll
```

## Test Reports
- The test report is automatically saved on `target` after execution
- Check the full report in `target/karate-reports/karate-summary.html`

## Performance Tests
- To run performance tests, use the script below
```shell
$  mvn clean test-compile gatling:test
```
- The test results will be available at `target\gatling\perftest-xxx\index.html`