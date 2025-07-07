import 'package:boringssl_ffi/crypto/crypto.dart';
import 'package:boringssl_ffi/src/encoding/encoding.dart';
import 'package:flutter_test/flutter_test.dart';

void testFunc(Map<String, dynamic> testVector) {
  final data = hex.decode(testVector['IN']);
  final additionalData = hex.decode(testVector['AD']);
  final key = hex.decode(testVector['KEY']);
  final nonce = hex.decode(testVector['NONCE']);
  final tag = hex.decode(testVector['TAG']);
  final expectedCipherWithTag = hex.decode(testVector['CT']) + tag;

  final actualCipher = aead.sealAES_EAX(data, additionalData, key, nonce);

  expect(actualCipher, isNotNull);
  actualCipher!;

  if (!testVector.containsKey("FAILS")) {
    expect(
      actualCipher.sublist(0, expectedCipherWithTag.length),
      equals(expectedCipherWithTag),
    );
  } else {
    expect(actualCipher, isNot(equals(expectedCipherWithTag)));
  }
}
