import '../../../../grill_testing/grill_benchmark.dart';
import '../../../../grill_testing/grill_testing.dart';
import '../../../helpers.dart';
import 'package:boringssl_ffi/crypto/crypto.dart';
import 'dart:convert';
import 'derive_test_vectors.dart';

GrillTestResult hashingTest([int? iterations]) {
  return group('PBKDF2 HMAC SHA384 Derive', () {
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
          final password = hex.decode(testVector['password']);
          final salt = hex.decode(testVector['salt']);
          final int iterations = testVector['iterations'];
          final int keyLength = testVector['keyLength'];
          final String? expectedHashHex = testVector['output'];

          final actualHash = pbkdf2HMAC.deriveKeySHA384(password, salt, iterations, keyLength);

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
  return group('PBKDF2 HMAC SHA384 Derive', () {
    // load the test vector data
    final String jsonString = testVectorsStr;

    List<Map<String, dynamic>> testVectors =
        (json.decode(jsonString) as List<dynamic>)
            .map<Map<String, dynamic>>((item) => item as Map<String, dynamic>)
            .toList();

    
    for (final testVector in testVectors) {
      final password = hex.decode(testVector['password']);
      final salt = hex.decode(testVector['salt']);
      final int iterations = testVector['iterations'];
      final int keyLength = testVector['keyLength'];
      testBenchmark(testVector['name'], () {
        pbkdf2HMAC.deriveKeySHA384(password, salt, iterations, keyLength);
      }, iterations: iterations);
    }
  });
}
