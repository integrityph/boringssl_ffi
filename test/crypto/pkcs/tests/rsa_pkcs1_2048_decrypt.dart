import 'package:boringssl_ffi/crypto/crypto.dart';
import 'package:boringssl_ffi/crypto/pkcs/rsa/rsa.dart';
import 'package:boringssl_ffi/src/encoding/encoding.dart';
import 'package:flutter_test/flutter_test.dart';

void testFunc(Map<String, dynamic> testVector) {
  final pkcs8Bytes = hex.decode(testVector['privKey'] as String);
  final privateKeyDer = pkcs8Bytes.sublist(26); // remove the v8 envelope to get v1
  final msg = hex.decode(testVector['msg'] as String);
  final ct = hex.decode(testVector['ct'] as String);
  final expectedResult = testVector['result'];

  final actualMsg = rsa.decryptSHA1PKCS1(privateKeyDer, ct);

  expect(actualMsg, (expectedResult=="valid") ? isNotNull : isNull);
  if (expectedResult=="invalid") {
    return;
  }
  actualMsg!;

  expect(actualMsg, equals(msg));
}
