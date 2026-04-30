import 'package:boringssl_ffi/crypto/crypto.dart';
import 'package:boringssl_ffi/crypto/pkcs/rsa/rsa.dart';
import 'package:boringssl_ffi/src/encoding/encoding.dart';
import 'package:boringssl_ffi/src/logging/logging.dart';
import 'package:flutter_test/flutter_test.dart';

void testFunc(Map<String, dynamic> testVector) {
  final publicKeyDer = hex.decode(testVector['pubKey'] as String);
  // final publicKeyDer = pkcs8Bytes.sublist(26); // remove the v8 envelope to get v1
  final msg = hex.decode(testVector['msg'] as String);
  // final comment = testVector['comment'] as String;
  final sig = hex.decode(testVector['sig'] as String);
  final expectedResult = testVector['result'];
  final sha = testVector['sha'] as String;
  
  bool? actualResult;
  switch(sha) {
    case "SHA-1":
      final digest = sha1.hash(msg)!;
      actualResult = rsa.verifySHA1DigestPKCS1(publicKeyDer, digest, sig);
      break;
    case "SHA-224":
      final digest = sha224.hash(msg)!;
      actualResult = rsa.verifySHA224DigestPKCS1(publicKeyDer, digest, sig);
      break;
    case "SHA-256":
      final digest = sha256.hash(msg)!;
      actualResult = rsa.verifySHA256DigestPKCS1(publicKeyDer, digest, sig);
      break;
    case "SHA-384":
      final digest = sha384.hash(msg)!;
      actualResult = rsa.verifySHA384DigestPKCS1(publicKeyDer, digest, sig);
      break;
    case "SHA-512":
      final digest = sha512.hash(msg)!;
      actualResult = rsa.verifySHA512DigestPKCS1(publicKeyDer, digest, sig);
      break;
    case "SHA-512_256":
      final digest = sha512_256.hash(msg)!;
      actualResult = rsa.verifySHA512_256DigestPKCS1(publicKeyDer, digest, sig);
      break;
    default:
      logger.log("unknown sha value $sha");
      return; // Skip unsupported hashes
  }

  if (expectedResult == "invalid") {
    expect(actualResult, equals(false));
    return;
  } else if (expectedResult == "acceptable" && actualResult == false) {
    return;
  }

  expect(actualResult, isNotNull);
  expect(actualResult, equals(true));
}
