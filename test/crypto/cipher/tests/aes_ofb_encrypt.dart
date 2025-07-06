import 'package:boringssl_ffi/crypto/crypto.dart';
import 'package:boringssl_ffi/src/encoding/hex.dart';
import 'package:flutter_test/flutter_test.dart';

void testFunc(Map<String, dynamic> testVector) {
  final data = hex.decode(testVector['PLAINTEXT']);
  final expectedCipher = hex.decode(testVector['CIPHERTEXT']);
  final key = hex.decode(testVector['KEY']);
  final ivec = hex.decode(testVector['IV']);
  final int num = 0;

  final actualCipher = aes.ofb.encrypt(data, key, ivec, num);

  expect(actualCipher, isNotNull);
  actualCipher!;

  expect(actualCipher.cipher, equals(expectedCipher));
}
