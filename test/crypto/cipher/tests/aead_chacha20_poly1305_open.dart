import 'package:boringssl_ffi/crypto/crypto.dart';
import 'package:boringssl_ffi/src/encoding/encoding.dart';
import 'package:flutter_test/flutter_test.dart';

void testFunc(Map<String, dynamic> testVector) {
  final tag = hex.decode(testVector['TAG']);
  final dataWithTag = hex.decode(testVector['CT']) + tag;
  final additionalData = hex.decode(testVector['AD']);
  final key = hex.decode(testVector['KEY']);
  final nonce = hex.decode(testVector['NONCE']);
  final expectedCipher = hex.decode(testVector['IN']);

  final actualCipher = aead.openChaCha20Poly1305(dataWithTag, additionalData, key, nonce, tagLength: tag.length);

  expect(actualCipher, isNotNull);
  actualCipher!;

  if (!testVector.containsKey("FAILS")) {
    expect(
      actualCipher,
      equals(expectedCipher),
    );
  } else {
    expect(actualCipher, isNot(equals(expectedCipher)));
  }
}
