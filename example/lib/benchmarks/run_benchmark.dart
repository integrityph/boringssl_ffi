import 'dart:math' as math;

Future<double> runBenchmark(String name, Function func, int iterations) async {
    Stopwatch watch = Stopwatch();
    List<double> runTime = List.filled(iterations, 0);
    //first call to establish FFI
    func();
    for (int i = 0; i < iterations; i++) {
      watch.start();
      func();
      watch.stop();
      runTime[i] = (watch.elapsedTicks / watch.frequency) * 1_000_000;
      watch.reset();
    }
    List<double> timeMs = runTime.map<double>((d) => d).toList();
    final double sumMs = timeMs.reduce((a, b) => a + b);
    final double avgMs = timeMs.isEmpty ? 0.0 : sumMs / timeMs.length;
    final double minMs = timeMs.isEmpty
        ? 0
        : timeMs.reduce((a, b) => a < b ? a : b);
    final double maxMs = timeMs.isEmpty
        ? 0
        : timeMs.reduce((a, b) => a > b ? a : b);
    double medianMs = 0.0;
    if (timeMs.isNotEmpty) {
      // Create a mutable copy to sort
      final List<double> sortedTimeMs = List<double>.from(timeMs)..sort();
      final int middle = sortedTimeMs.length ~/ 2; // Integer division

      if (sortedTimeMs.length % 2 == 1) {
        // Odd number of elements: median is the middle element
        medianMs = sortedTimeMs[middle].toDouble();
      } else {
        // Even number of elements: median is the average of the two middle elements
        medianMs = (sortedTimeMs[middle - 1] + sortedTimeMs[middle]) / 2.0;
      }
    }
    double stdDevMs = 0.0;
    if (timeMs.length > 1) {
      // Need at least 2 data points for std dev
      final double mean = avgMs;
      final double sumOfSquaredDifferences = timeMs
          .map((x) => math.pow(x - mean, 2))
          .reduce((a, b) => a + b)
          .toDouble();
      final double variance =
          sumOfSquaredDifferences /
          (timeMs.length - 1); // Sample standard deviation
      stdDevMs = math.sqrt(variance);
    } else if (timeMs.length == 1) {
      stdDevMs = 0.0; // Standard deviation is 0 for a single data point
    }
    print("test stats for $name - iterations:$iterations (in microseconds)");
    print(" - total: ${(sumMs / 1000).toStringAsFixed(2)}ms");
    print(" - avg: ${avgMs.toStringAsFixed(2)}µs");
    print(" - median: ${medianMs.toStringAsFixed(2)}µs");
    print(" - min: ${minMs.toStringAsFixed(2)}µs");
    print(" - max: ${maxMs.toStringAsFixed(2)}µs");
    print(" - std: ${stdDevMs.toStringAsFixed(2)}µs");
    return avgMs;
}
