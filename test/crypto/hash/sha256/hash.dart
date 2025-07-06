import '../../../../grill_testing/grill_benchmark.dart';
import '../../../../grill_testing/grill_testing.dart';
import '../../../helpers.dart';
import 'package:boringssl_ffi/crypto/crypto.dart';
import 'dart:convert';
import 'hash_test_vectors.dart';

GrillTestResult hashingTest([int? iterations]) {
  return group('SHA256 Hashing', () {
    // load the test vector data
    final String jsonString = testVectorsStr;

    List<Map<String, dynamic>> testVectors =
        (json.decode(jsonString) as List<dynamic>)
            .map<Map<String, dynamic>>((item) => item as Map<String, dynamic>)
            .toList();

    
    for (final testVector in testVectors) {
      test(testVector['name'], () {
        bool testPassed = true;
        try {
          final input = (testVector['input'] as String).codeUnits;
          final String? expectedHashHex = testVector['output'];

          final actualHash = sha256.hash(input);

          expect(actualHash, (expectedHashHex == null) ? isNull : isNotNull);
          if (expectedHashHex != null) {
            expect(
              hex.encode(actualHash!),
              equalsIgnoringCase(expectedHashHex),
            );
          }
        } catch (e) {
          print(e);
          testPassed = false;
        }
        expect(testPassed, testVector['shouldPass']);
      }, iterations: iterations);
    }
  });
}

GrillTestResult hashingBenchmark([int? iterations]) {
  return group('SHA256 Hashing', () {
    // load the test vector data
    final String jsonString = testVectorsStr;

    List<Map<String, dynamic>> testVectors =
        (json.decode(jsonString) as List<dynamic>)
            .map<Map<String, dynamic>>((item) => item as Map<String, dynamic>)
            .toList();

    
    for (final testVector in testVectors) {
      final input = (testVector['input'] as String).codeUnits;
      testBenchmark(testVector['name'], () {
        sha256.hash(input);
      }, iterations: iterations);
    }
  });
}
