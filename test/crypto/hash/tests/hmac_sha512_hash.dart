import 'package:boringssl_ffi/crypto/crypto.dart';
import 'package:boringssl_ffi/src/encoding/encoding.dart';
import 'package:flutter_test/flutter_test.dart';

void testFunc(Map<String, dynamic> testVector) {
  final key = hex.decode(testVector['Key']);
  final input = hex.decode(testVector['Msg']);
  final expectedHash = hex.decode(testVector['Mac']);
  final outLen = int.parse(testVector['Tlen']);

  final actualHash = hmac.hmacSHA512(key, input);

  expect(actualHash, isNotNull);
  actualHash!;

  expect(actualHash.sublist(0, outLen), equals(expectedHash));
}
