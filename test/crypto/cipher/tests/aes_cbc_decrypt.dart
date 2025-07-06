import 'package:boringssl_ffi/crypto/crypto.dart';
import 'package:boringssl_ffi/src/encoding/hex.dart';
import 'package:flutter_test/flutter_test.dart';

void testFunc(Map<String, dynamic> testVector) {
  final data = hex.decode(testVector['Ciphertext']);
  final expectedCipher = hex.decode(testVector['Plaintext']);
  final key = hex.decode(testVector['Key']);
  final ivec = hex.decode(testVector['IV']);

  final actualCipher = aes.cbc.decrypt(data, key, ivec);

  expect(actualCipher, isNotNull);
  actualCipher!;

  expect(
    actualCipher,
    equals(expectedCipher),
    reason:
        "actual: ${hex.encode(actualCipher)} - expected: ${hex.encode(expectedCipher)}",
  );
}
