import 'package:boringssl_ffi/crypto/crypto.dart';
import 'package:boringssl_ffi/src/encoding/encoding.dart';
import 'package:flutter_test/flutter_test.dart';

void testFunc(Map<String, dynamic> testVector) {
  final input = hex.decode(testVector['Msg']);
  final expectedHash = hex.decode(testVector['MD']);
  final int inputLen = int.parse(testVector['Len']) ~/ 8;

  final actualHash = sha1.hash(input.sublist(0, inputLen));

  expect(actualHash, isNotNull);
  actualHash!;

  expect(actualHash, equals(expectedHash));
}
