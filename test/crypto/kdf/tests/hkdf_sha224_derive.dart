import 'package:boringssl_ffi/crypto/crypto.dart';
import 'package:boringssl_ffi/src/encoding/encoding.dart';
import 'package:flutter_test/flutter_test.dart';

void testFunc(Map<String, dynamic> testVector) {
  final secret = hex.decode(testVector['secret']);
  final salt = hex.decode(testVector['salt']);
  final info = hex.decode(testVector['info']);
  final int keyLength = testVector['keyLength'];
  final expectedHash = hex.decode(testVector['output']);

  final actualHash = hkdf.deriveKeySHA224OneShot(secret, salt, info, keyLength);

  expect(actualHash, isNotNull);
  expect(actualHash, equals(expectedHash));
}
