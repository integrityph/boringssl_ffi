import 'package:boringssl_ffi/crypto/crypto.dart';
import 'package:boringssl_ffi/crypto/pkcs/rsa/rsa.dart';
import 'package:flutter_test/flutter_test.dart';

void testFunc(Map<String, dynamic> testVector) {
  final int bits = testVector['bits'];
  final int? exponent = testVector['exponent'];

  final actualKey = exponent==null ? rsa.generateKeySet(bits) : rsa.generateKeySet(bits, exponent);

  expect(actualKey, isNotNull);
  actualKey!;

  // --- CRYPTOGRAPHIC DATA SIZES ---
  final int modulusBytes = bits ~/ 8;
  // Exponent 65537 (0x010001) takes exactly 3 bytes
  final int expBytes = (BigInt.from(exponent ?? RSA.F4).bitLength / 8).ceil();

  // --- ASN.1 DER Size Calculators ---
  // Calculates the number of bytes required to define the length of an ASN.1 payload
  int asn1LengthPrefixSize(int payloadLength) {
    if (payloadLength < 128) return 1;
    if (payloadLength < 256) return 2; // 1 marker byte + 1 length byte
    if (payloadLength < 65536) return 3; // 1 marker byte + 2 length bytes
    return 4; 
  }

  // Minimum size: Tag(1) + Length(1-4) + Bytes
  int minIntSize(int bytes) => 1 + asn1LengthPrefixSize(bytes) + bytes;
  // Maximum size: (+1 byte if the high bit is 1, requiring a 0x00 padding byte)
  int maxIntSize(int bytes) => 1 + asn1LengthPrefixSize(bytes + 1) + bytes + 1;

  // --- PUBLIC KEY (PKCS#1) ---
  // RSAPublicKey ::= SEQUENCE { modulus INTEGER, publicExponent INTEGER }
  final int pubPayloadMin = minIntSize(modulusBytes) + minIntSize(expBytes);
  final int pubPayloadMax = maxIntSize(modulusBytes) + maxIntSize(expBytes);

  final int pubMin = 1 + asn1LengthPrefixSize(pubPayloadMin) + pubPayloadMin;
  final int pubMax = 1 + asn1LengthPrefixSize(pubPayloadMax) + pubPayloadMax;

  // --- PRIVATE KEY (PKCS#1) ---
  // RSAPrivateKey ::= SEQUENCE { version, n, e, d, p, q, dmp1, dmq1, iqmp }
  final int halfBytes = modulusBytes ~/ 2;
  
  // Note: 'd' can occasionally be mathematically slightly shorter than 'n', 
  // so we add a little slack (-2 bytes) to the minimum bounds to prevent flakes.
  final int privPayloadMin = 
      minIntSize(1) + // version (1 byte)
      minIntSize(modulusBytes) + // n
      minIntSize(expBytes) +     // e
      minIntSize(modulusBytes - 2) + // d 
      (minIntSize(halfBytes) * 5); // p, q, dmp1, dmq1, iqmp

  final int privPayloadMax = 
      maxIntSize(1) + // version
      maxIntSize(modulusBytes) + // n
      maxIntSize(expBytes) +     // e
      maxIntSize(modulusBytes) + // d
      (maxIntSize(halfBytes) * 5); // p, q, dmp1, dmq1, iqmp

  final int privMin = 1 + asn1LengthPrefixSize(privPayloadMin) + privPayloadMin;
  final int privMax = 1 + asn1LengthPrefixSize(privPayloadMax) + privPayloadMax;

  // --- ASSERTIONS ---
  expect(actualKey.publicKey[0], equals(0x30), reason: "Public key missing ASN.1 sequence header");
  expect(actualKey.privateKey[0], equals(0x30), reason: "Private key missing ASN.1 sequence header");
  
  expect(
    actualKey.publicKey.length, 
    inInclusiveRange(pubMin, pubMax),
    reason: "Public key byte length out of mathematical bounds"
  );
  
  expect(
    actualKey.privateKey.length, 
    inInclusiveRange(privMin, privMax),
    reason: "Private key byte length out of mathematical bounds"
  );
}
