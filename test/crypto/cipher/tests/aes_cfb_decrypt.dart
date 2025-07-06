import 'package:boringssl_ffi/crypto/crypto.dart';
import 'package:boringssl_ffi/src/encoding/hex.dart';
import 'package:flutter_test/flutter_test.dart';

void testFunc(Map<String, dynamic> testVector) {
  final data = hex.decode(testVector['CIPHERTEXT']);
  final expectedCipher = hex.decode(testVector['PLAINTEXT']);
  final key = hex.decode(testVector['KEY']);
  final ivec = hex.decode(testVector['IV']);

  final actualCipher = aes.cfb.decrypt(data, key, ivec, 0);

  expect(actualCipher, isNotNull);
  actualCipher!;

  expect(
    actualCipher.cipher,
    equals(expectedCipher),
    reason:
        "actual: ${hex.encode(actualCipher.cipher)} - expected: ${hex.encode(expectedCipher)}",
  );
}
