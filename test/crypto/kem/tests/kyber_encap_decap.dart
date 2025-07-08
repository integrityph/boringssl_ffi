import 'package:boringssl_ffi/crypto/crypto.dart';
import 'package:boringssl_ffi/src/encoding/encoding.dart';
import 'package:flutter_test/flutter_test.dart';

void testFunc(Map<String, dynamic> testVector) {
  final generateEntropy = hex.decode(testVector['generateEntropy']);
  final encapEntropyPreHash = hex.decode(testVector['encapEntropyPreHash']);
  final pk = hex.decode(testVector['pk']);
  final ct = hex.decode(testVector['ct']);
  final ss = hex.decode(testVector['ss']);

  // ignore: invalid_use_of_protected_member
  final kyberSession = kyber.initSessionExternalEntropy(generateEntropy);

  expect(kyberSession, isNotNull);
  kyberSession!;

  expect(kyberSession.publicKey, isNotNull);
  kyberSession.publicKey!;

  expect(kyberSession.publicKey, equals(pk));

  // Encapsulate
  // ignore: invalid_use_of_protected_member
  final encapKey = kyber.encapsulateExternalEntropy(kyberSession.publicKey!, encapEntropyPreHash);

  expect(encapKey, isNotNull);
  encapKey!;

  expect(encapKey.cipher, equals(ct));
  expect(encapKey.sharedSecret, equals(ss));

  // Decapsulate
  final actualSS = kyberSession.decapsulate(encapKey.cipher);
  expect(actualSS, isNotNull);

  expect(actualSS, equals(ss));
}
