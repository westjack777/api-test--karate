package AppPerformance;

import com.intuit.karate.junit5.Karate;

class AppPerformanceTest {

    @Karate.Test
    Karate testAll() {
        return Karate.run().relativeTo(getClass());
    }
}
