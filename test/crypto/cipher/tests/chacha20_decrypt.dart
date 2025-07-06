import 'package:boringssl_ffi/crypto/crypto.dart';
import 'package:boringssl_ffi/src/encoding/hex.dart';
import 'package:flutter_test/flutter_test.dart';

void testFunc(Map<String, dynamic> testVector) {
  final data = hex.decode(testVector['Ciphertext']);
  final expectedCipher = hex.decode(testVector['Plaintext']);
  final key = hex.decode(testVector['Key']);
  final nonce = hex.decode(testVector['IV']);
  final counter = testVector['Counter'];

  final actualCipher = chacha20.decrypt(data, key, nonce, counter);

  expect(actualCipher, isNotNull);
  actualCipher!;


    expect(actualCipher, equals(expectedCipher));
}
