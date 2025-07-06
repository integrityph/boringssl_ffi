import 'dart:typed_data';

import 'package:boringssl_ffi/crypto/crypto.dart';
import 'package:boringssl_ffi/src/encoding/hex.dart';
import 'package:flutter_test/flutter_test.dart';

void testFunc(Map<String, dynamic> testVector) {
  final data = hex.decode(testVector['Plaintext']);
  final expectedCipher = hex.decode(testVector['Ciphertext']);
  final key = hex.decode(testVector['Key']);
  final ivec = hex.decode(testVector['IV']);
  final ecountBuf = Uint8List(16);
  final int num = 0;

  final actualCipher = aes.ctr.encrypt(data, key, ivec, ecountBuf, num);

  expect(actualCipher, isNotNull);
  actualCipher!;

  expect(actualCipher.cipher, equals(expectedCipher));
}
