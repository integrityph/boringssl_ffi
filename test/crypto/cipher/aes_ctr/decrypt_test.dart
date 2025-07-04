import 'package:boringssl_ffi/src/encoding/hex.dart';
import 'package:boringssl_ffi/src/logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';

import '../../../../grill_testing/grill_benchmark.dart';
import '../../../../grill_testing/grill_testing.dart';
import '../../../helpers.dart';
import 'package:boringssl_ffi/crypto/crypto.dart';
import 'dart:convert';
import 'aes_ctr_test_vectors.dart';

GrillTestResult decryptTest([int? iterations]) {
  return group('AES CTR decryption', () {
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
          final data = hex.decode(testVector['output']);
          final String? expectedCipherHex = testVector['input'];
          final key = hex.decode(testVector['key']);
          final ivec = hex.decode(testVector['ivec']);
          final ecountBuf = hex.decode(testVector['ecount_buf']);
          final int num = testVector['num'];

          final actualCipher = aes.ctr.decrypt(data, key, ivec, ecountBuf, num);

          expect(
            actualCipher,
            (expectedCipherHex == null) ? isNull : isNotNull,
          );
          if (expectedCipherHex != null) {
            expect(
              hex.encode(actualCipher!.cipher),
              equalsIgnoringCase(expectedCipherHex),
            );
          }
        } catch (e) {
          logger.configure(showStackTraces: true);
          logger.log("error in unit test ${testVector['name']}: $e\n${Trace.current()}");
          testPassed = false;
        }
        expect(testVector['shouldPass'], testPassed);
      }, iterations: iterations);
    }
  });
}

GrillTestResult decryptBenchmark([int? iterations]) {
  return group('AES CTR decryption', () {
    // load the test vector data
    final String jsonString = testVectorsStr;

    List<Map<String, dynamic>> testVectors =
        (json.decode(jsonString) as List<dynamic>)
            .map<Map<String, dynamic>>((item) => item as Map<String, dynamic>)
            .toList();

    
    for (final testVector in testVectors) {
      final data = hex.decode(testVector['output']);
      final key = hex.decode(testVector['key']);
      final ivec = hex.decode(testVector['ivec']);
      final ecountBuf = hex.decode(testVector['ecount_buf']);
      final int num = testVector['num'];
      testBenchmark(testVector['name'], () {
        aes.ctr.encrypt(data, key, ivec, ecountBuf, num);
      }, iterations: iterations);
    }
  });
}
