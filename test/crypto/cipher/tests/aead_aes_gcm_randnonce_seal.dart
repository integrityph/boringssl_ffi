import 'package:boringssl_ffi/crypto/crypto.dart';
import 'package:boringssl_ffi/src/encoding/encoding.dart';
import 'package:flutter_test/flutter_test.dart';

void testFunc(Map<String, dynamic> testVector) {
  final data = hex.decode(testVector['IN']);
  final additionalData = hex.decode(testVector['AD']);
  final key = hex.decode(testVector['KEY']);
  final nonce = hex.decode(testVector['NONCE']);

  final actualCipher = aead.sealAES_GCM_RandNonce(data, additionalData, key, nonce);

  expect(actualCipher, isNotNull);
  actualCipher!;

  // This algorithm cannot be unit tested for seal alone because the nonce is randomly generated
  // internally. So, we have to `open` the cipher and compare it to the original input
  final actualData = aead.openAES_GCM_RandNonce(actualCipher, additionalData, key, nonce);

  expect(actualData, isNotNull);
  actualData!;

  if (!testVector.containsKey("FAILS")) {
    expect(
      actualData,
      equals(data),
    );
  } else {
    expect(actualData, isNot(equals(data)));
  }
}
