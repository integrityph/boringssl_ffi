import 'dart:typed_data';

import 'package:boringssl_ffi/crypto/crypto.dart';
import 'package:boringssl_ffi/crypto/pkcs/rsa/rsa.dart';
import 'package:boringssl_ffi/src/encoding/encoding.dart';
import 'package:boringssl_ffi/src/logging/logging.dart';
import 'package:flutter_test/flutter_test.dart';

void testFunc(Map<String, dynamic> testVector) {
  final pkcs8Bytes = hex.decode(testVector['privKey'] as String);
  final privateKeyDer = pkcs8Bytes.sublist(26); // remove the v8 envelope to get v1
  final msg = hex.decode(testVector['msg'] as String);
  final ct = hex.decode(testVector['ct'] as String);
  final label = testVector['label'] == "" ? null : hex.decode(testVector['label'] as String);
  final expectedResult = testVector['result'];
  final sha = testVector['sha'] as String;
  final mgfSha = testVector['mgfSha'] as String;

  if (mgfSha != "SHA-1" && mgfSha != sha) {
    return;
  }

  
  final bool useSha1Mgf1 = (mgfSha == "SHA-1");

  Uint8List? actualMsg;
  switch(sha) {
    case "SHA-1":
      // Clean, simple, no useless parameters!
      actualMsg = rsa.decryptSHA1PKCS1_OAEP(privateKeyDer, ct, label: label);
      break;
    case "SHA-224":
      actualMsg = rsa.decryptSHA224PKCS1_OAEP(privateKeyDer, ct, label: label, useSHA1ForMGF1: useSha1Mgf1);
      break;
    case "SHA-256":
      actualMsg = rsa.decryptSHA256PKCS1_OAEP(privateKeyDer, ct, label: label, useSHA1ForMGF1: useSha1Mgf1);
      break;
    case "SHA-384":
      actualMsg = rsa.decryptSHA384PKCS1_OAEP(privateKeyDer, ct, label: label, useSHA1ForMGF1: useSha1Mgf1);
      break;
    case "SHA-512":
      actualMsg = rsa.decryptSHA512PKCS1_OAEP(privateKeyDer, ct, label: label, useSHA1ForMGF1: useSha1Mgf1);
      break;
    case "SHA-512_256":
      actualMsg = rsa.decryptSHA512_256PKCS1_OAEP(privateKeyDer, ct, label: label, useSHA1ForMGF1: useSha1Mgf1);
      break;
    default:
      logger.log("unknown sha value $sha");
      return; // Skip unsupported hashes
  }

  if (expectedResult == "invalid") {
    expect(actualMsg, isNull);
    return;
  } else if (expectedResult == "acceptable" && actualMsg == null) {
    return;
  }

  expect(actualMsg, isNotNull);
  expect(actualMsg, equals(msg));
}
