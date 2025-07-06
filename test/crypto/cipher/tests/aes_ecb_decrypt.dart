import 'package:boringssl_ffi/crypto/crypto.dart';
import 'package:boringssl_ffi/src/encoding/hex.dart';
import 'package:flutter_test/flutter_test.dart';

void testFunc(Map<String, dynamic> testVector) {
  final data = hex.decode(testVector['CIPHERTEXT']);
  final expectedCipher = hex.decode(testVector['PLAINTEXT']);
  final key = hex.decode(testVector['KEY']);

  final actualCipher = aes.ecb.decrypt(data, key);

  expect(actualCipher, isNotNull);
  actualCipher!;

  expect(actualCipher, expectedCipher);
}
