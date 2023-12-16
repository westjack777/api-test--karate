package performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class PerfTest extends Simulation {

  val protocol = karateProtocol()

  val users = scenario("Create random users").exec(karateFeature("classpath:AppPerformance/performance/PerformanceTest.feature"))

  setUp(
    users.inject(
          atOnceUsers(1),
          nothingFor(4 seconds),
          constantUsersPerSec(1) during (3 seconds),
          constantUsersPerSec(2) during (10 seconds),
          rampUsersPerSec(2) to 10 during (20 seconds),
          nothingFor(5 seconds),
          constantUsersPerSec(1) during (5 seconds)
        ).protocols(protocol)
  )
}