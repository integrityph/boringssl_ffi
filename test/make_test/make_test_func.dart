import 'dart:convert';
import 'package:boringssl_ffi/src/logging/logging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stack_trace/stack_trace.dart';
import '../parsing.dart';

Function() makeTest(
  String name,
  String testVector,
  Function(Map<String, dynamic> testVector) testFunc, {
  bool Function(Map<String, dynamic>)? testVectorFilter,
  Map<String, dynamic> Function(Map<String, dynamic> sample)?
  testVectorModifier,
  dynamic tags,
  String keyValueSeparator = ":",
  String unnamedTagKey = "",
}) {
  return () {
    group(name, () {
      List<Map<String, dynamic>> testVectors = keyValueToJSON(
        testVector,
        "",
        separator: keyValueSeparator,
        unnamedTagKey: unnamedTagKey,
      );

      if (testVectorFilter != null) {
        testVectors = testVectors.where(testVectorFilter).toList();
      }

      if (testVectorModifier != null) {
        testVectors = testVectors
            .map<Map<String, dynamic>>(testVectorModifier)
            .toList();
      }

      int failCount = 0;
      for (final testVector in testVectors) {
        test(testVector['_name'], () {
          try {
            testFunc(testVector);
          } catch (e) {
            prettyPrintJSON(testVector);
            logger.configure(showStackTraces: true);
            logger.log(
              "error in unit test ${testVector['_name']}: $e\n${Trace.current()}",
            );
            failCount++;
            rethrow;
          }
        }, tags: tags);
      }
      tearDownAll(() {
        logger.log(
          "$name finished with ${testVectors.length - failCount}/${testVectors.length} passing",
          Level.info,
        );
      });
    });
  };
}

void prettyPrintJSON(dynamic val) {
  final encoder = JsonEncoder.withIndent('  ');
  final String json = encoder.convert(val);
  logger.log(json, Level.info);
}
