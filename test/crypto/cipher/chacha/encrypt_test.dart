import 'package:boringssl_ffi/src/encoding/hex.dart';
import 'package:boringssl_ffi/src/logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';

import '../../../../grill_testing/grill_benchmark.dart';
import '../../../../grill_testing/grill_testing.dart';
import '../../../helpers.dart';
import 'package:boringssl_ffi/crypto/crypto.dart';
import 'dart:convert';
import 'chacha_test_vectors.dart';

GrillTestResult encryptTest([int? iterations]) {
  return group('ChaCha encryption', () {
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
          final data = hex.decode(testVector['input']);
          final String? expectedCipherHex = testVector['output'];
          final key = hex.decode(testVector['key']);
          final nonce = hex.decode(testVector['nonce']);
          final counter = testVector['counter'];

          final actualCipher = chacha20.encrypt(data, key, nonce, counter);

          expect(
            actualCipher,
            (expectedCipherHex == null) ? isNull : isNotNull,
          );
          if (expectedCipherHex != null) {
            expect(
              hex.encode(actualCipher!),
              equalsIgnoringCase(expectedCipherHex),
            );
          }
        } catch (e) {
          log.configure(showStackTraces: true);
          log.log("error in unit test ${testVector['name']}: $e\n${Trace.current()}");
          testPassed = false;
        }
        expect(testPassed, testVector['shouldPass']);
      }, iterations: iterations);
    }
  });
}

GrillTestResult encryptBenchmark([int? iterations]) {
  return group('ChaCha encryption', () {
    // load the test vector data
    final String jsonString = testVectorsStr;

    List<Map<String, dynamic>> testVectors =
        (json.decode(jsonString) as List<dynamic>)
            .map<Map<String, dynamic>>((item) => item as Map<String, dynamic>)
            .toList();

    
    for (final testVector in testVectors) {
      final data = hex.decode(testVector['input']);
          final key = hex.decode(testVector['key']);
          final nonce = hex.decode(testVector['nonce']);
          final counter = testVector['counter'];
      testBenchmark(testVector['name'], () {
        chacha20.encrypt(data, key, nonce, counter);
      }, iterations: iterations);
    }
  });
}
