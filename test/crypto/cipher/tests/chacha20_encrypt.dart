import 'package:boringssl_ffi/crypto/crypto.dart';
import 'package:boringssl_ffi/src/encoding/hex.dart';
import 'package:flutter_test/flutter_test.dart';

void testFunc(Map<String, dynamic> testVector) {
  final data = hex.decode(testVector['Plaintext']);
  final expectedCipher = hex.decode(testVector['Ciphertext']);
  final key = hex.decode(testVector['Key']);
  final nonce = hex.decode(testVector['IV']);
  final counter = testVector['Counter'];

  final actualCipher = chacha20.encrypt(data, key, nonce, counter);

  expect(actualCipher, isNotNull);
  actualCipher!;


    expect(actualCipher, equals(expectedCipher));
}
