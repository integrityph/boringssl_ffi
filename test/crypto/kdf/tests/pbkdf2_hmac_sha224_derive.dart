import 'package:boringssl_ffi/crypto/crypto.dart';
import 'package:boringssl_ffi/src/encoding/encoding.dart';
import 'package:flutter_test/flutter_test.dart';

void testFunc(Map<String, dynamic> testVector) {
  final password = hex.decode(testVector['password']);
  final salt = hex.decode(testVector['salt']);
  final int iterations = testVector['iterations'];
  final int keyLength = testVector['keyLength'];
  final expectedHash = hex.decode(testVector['output']);

  final actualHash = pbkdf2HMAC.deriveKeySHA224(
    password,
    salt,
    iterations,
    keyLength,
  );

  expect(actualHash, isNotNull);
  expect(actualHash, equals(expectedHash));
}
