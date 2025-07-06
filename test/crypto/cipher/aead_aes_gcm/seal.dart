import 'package:boringssl_ffi/src/encoding/hex.dart';
import 'package:boringssl_ffi/src/logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';

import '../../../../grill_testing/grill_benchmark.dart';
import '../../../../grill_testing/grill_testing.dart';
import '../../../helpers.dart';
import 'package:boringssl_ffi/crypto/crypto.dart';
import 'dart:convert';
import '../../../parsing.dart';
import 'test_vector.dart';
import 'test_vector_nist.dart';

GrillTestResult sealTest([int? iterations]) {
  return group('AEAD AES GCM seal', () {
    // load the test vector data
    final String testStandard = testVectorsStr;
    final String testNIST = testVectorsNISTStr;

    List<Map<String, dynamic>> testVectors = keyValueToJSON(
      testStandard,
      "AEAD AES GCM seal",
    );

    testVectors = testVectors
        .where((sample) => !sample.containsKey("NO_SEAL"))
        .toList();

    for (final testVector in testVectors) {
      test(testVector['_name'], () {
        // prettyPrintJSON(testVector);
        // bool testPassed = true;
        try {
          final data = hex.decode(testVector['IN']);
          final additionalData = hex.decode(testVector['AD']);
          final key = hex.decode(testVector['KEY']);
          final nonce = hex.decode(testVector['NONCE']);
          final tag = hex.decode(testVector['TAG']);
          final expectedCipherWithTag = hex.decode(testVector['CT']) + tag;

          final actualCipher = aead.sealAES_GCM(
            data,
            additionalData,
            key,
            nonce,
          );

          expect(actualCipher, isNotNull);
          actualCipher!;

          if (!testVector.containsKey("FAILS")) {
            expect(
              actualCipher.sublist(0, expectedCipherWithTag.length),
              equals(expectedCipherWithTag),
            );
          } else {
            expect(actualCipher, isNot(equals(expectedCipherWithTag)));
          }
        } catch (e) {
          // prettyPrintJSON(testVector);
          logger.configure(showStackTraces: true);
          logger.log(
            "error in unit test ${testVector['_name']}: $e\n${Trace.current()}",
          );
        }
      }, iterations: iterations);
    }
  });
}

GrillTestResult sealBenchmark([int? iterations]) {
  return group('AEAD AES GCM seal', () {
    // load the test vector data
    final String jsonString = testVectorsStr;

    List<Map<String, dynamic>> testVectors =
        (json.decode(jsonString) as List<dynamic>)
            .map<Map<String, dynamic>>((item) => item as Map<String, dynamic>)
            .toList();

    for (final testVector in testVectors) {
      final data = hex.decode(testVector['data']);
      final additionalData = hex.decode(testVector['additionalData']);
      final key = hex.decode(testVector['key']);
      final nonce = hex.decode(testVector['nonce']);
      testBenchmark(testVector['_name'], () {
        aead.sealAES_GCM(data, additionalData, key, nonce);
      }, iterations: iterations);
    }
  });
}


