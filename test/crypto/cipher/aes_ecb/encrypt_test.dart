import 'package:boringssl_ffi/src/encoding/hex.dart';
import 'package:boringssl_ffi/src/logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';

import '../../../../grill_testing/grill_benchmark.dart';
import '../../../../grill_testing/grill_testing.dart';
import '../../../helpers.dart';
import 'package:boringssl_ffi/crypto/crypto.dart';
import 'dart:convert';
import 'aes_ecb_test_vectors.dart';

GrillTestResult encryptTest([int? iterations]) {
  return group('AES ECB encryption', () {
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

          final actualCipher = aes.ecb.encrypt(data, key);

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
        expect(testVector['shouldPass'], testPassed);
      }, iterations: iterations);
    }
  });
}

GrillTestResult encryptBenchmark([int? iterations]) {
  return group('AES ECB encryption', () {
    // load the test vector data
    final String jsonString = testVectorsStr;

    List<Map<String, dynamic>> testVectors =
        (json.decode(jsonString) as List<dynamic>)
            .map<Map<String, dynamic>>((item) => item as Map<String, dynamic>)
            .toList();

    
    for (final testVector in testVectors) {
      final data = hex.decode(testVector['input']);
      final key = hex.decode(testVector['key']);
      testBenchmark(testVector['name'], () {
        aes.ecb.encrypt(data, key);
      }, iterations: iterations);
    }
  });
}
