import 'dart:math';

import 'package:boringssl_ffi/crypto/crypto.dart';
import 'package:boringssl_ffi/crypto/pkcs/rsa/rsa.dart';
import 'package:boringssl_ffi/src/encoding/encoding.dart';
import 'package:boringssl_ffi/src/helpers/conversion/list_to_bytearray.dart';
import 'package:flutter_test/flutter_test.dart';

void testFunc(Map<String, dynamic> testVector) {
  final bits = testVector['bits'] as int;
  final fips = testVector['fips'] as bool;
  final msgType = testVector['msgType'] as String;
  final cipherPadding = testVector['cipherPadding'] as String;
  final cipherSha = testVector['cipherSha'] as Map<String, dynamic>;
  final cipherMGF1Sha1 = testVector['cipherMGF1Sha1'];
  final sigPadding = testVector['sigPadding'];
  final sigSha = testVector['sigSha'];
  final randomKey = testVector['randomKey'] as bool;
  final privateKey = hex.decode(testVector['privateKey'] as String).toUint8List();
  final publicKey = hex.decode(testVector['publicKey'] as String).toUint8List();
  
  // generate keys
  final keyset = randomKey
    ? fips
      ? rsa.generateKeySetFIPS(bits)
      : rsa.generateKeySet(bits)
    : (privateKey: privateKey, publicKey: publicKey);

  expect(keyset, isNotNull, reason:"Expected key generation to work");
  keyset!;

  final msg = _getMessage(msgType, bits, cipherPadding, cipherSha["bytes"]);

  // encrypt/decrypt message
  List<int>? ct;
  List<int>? dt;
  final ctNotNullReason = "Expected cipher text shouldn't be null. msg: ${hex.encode(msg)}, keyset.publicKey: ${hex.encode(keyset.publicKey)}";
  switch (cipherSha["name"]) {
    case "SHA-1":
      switch(cipherPadding) {
        case "NO_PADDING":
          ct = rsa.encryptSHA1NoPadding(keyset.publicKey, msg);
          expect(ct, isNotNull, reason: ctNotNullReason);
          dt = rsa.decryptSHA1NoPadding(keyset.privateKey, ct!);
        case "PKCS1":
          ct = rsa.encryptSHA1PKCS1(keyset.publicKey, msg);
          expect(ct, isNotNull, reason: ctNotNullReason);
          dt = rsa.decryptSHA1PKCS1(keyset.privateKey, ct!);
        case "PKCS1_OAEP":
          ct = rsa.encryptSHA1PKCS1_OAEP(keyset.publicKey, msg);
          expect(ct, isNotNull, reason: ctNotNullReason);
          dt = rsa.decryptSHA1PKCS1_OAEP(keyset.privateKey, ct!);
        default:
          throw Exception("Unknow cipherSha ${cipherSha["name"]}");
      }
    case "SHA-224":
      switch(cipherPadding) {
        case "NO_PADDING":
          ct = rsa.encryptSHA224NoPadding(keyset.publicKey, msg);
          expect(ct, isNotNull, reason: ctNotNullReason);
          dt = rsa.decryptSHA224NoPadding(keyset.privateKey, ct!);
        case "PKCS1":
          ct = rsa.encryptSHA224PKCS1(keyset.publicKey, msg);
          expect(ct, isNotNull, reason: ctNotNullReason);
          dt = rsa.decryptSHA224PKCS1(keyset.privateKey, ct!);
        case "PKCS1_OAEP":
          ct = rsa.encryptSHA224PKCS1_OAEP(keyset.publicKey, msg, useSHA1ForMGF1: cipherMGF1Sha1);
          expect(ct, isNotNull, reason: ctNotNullReason);
          dt = rsa.decryptSHA224PKCS1_OAEP(keyset.privateKey, ct!, useSHA1ForMGF1: cipherMGF1Sha1);
        default:
          throw Exception("Unknow cipherSha ${cipherSha["name"]}");
      }
    case "SHA-256":
      switch(cipherPadding) {
        case "NO_PADDING":
          ct = rsa.encryptSHA256NoPadding(keyset.publicKey, msg);
          expect(ct, isNotNull, reason: ctNotNullReason);
          dt = rsa.decryptSHA256NoPadding(keyset.privateKey, ct!);
        case "PKCS1":
          ct = rsa.encryptSHA256PKCS1(keyset.publicKey, msg);
          expect(ct, isNotNull, reason: ctNotNullReason);
          dt = rsa.decryptSHA256PKCS1(keyset.privateKey, ct!);
        case "PKCS1_OAEP":
          ct = rsa.encryptSHA256PKCS1_OAEP(keyset.publicKey, msg, useSHA1ForMGF1: cipherMGF1Sha1);
          expect(ct, isNotNull, reason: ctNotNullReason);
          dt = rsa.decryptSHA256PKCS1_OAEP(keyset.privateKey, ct!, useSHA1ForMGF1: cipherMGF1Sha1);
        default:
          throw Exception("Unknow cipherSha ${cipherSha["name"]}");
      }
    case "SHA-384":
      switch(cipherPadding) {
        case "NO_PADDING":
          ct = rsa.encryptSHA384NoPadding(keyset.publicKey, msg);
          expect(ct, isNotNull, reason: ctNotNullReason);
          dt = rsa.decryptSHA384NoPadding(keyset.privateKey, ct!);
        case "PKCS1":
          ct = rsa.encryptSHA384PKCS1(keyset.publicKey, msg);
          expect(ct, isNotNull, reason: ctNotNullReason);
          dt = rsa.decryptSHA384PKCS1(keyset.privateKey, ct!);
        case "PKCS1_OAEP":
          ct = rsa.encryptSHA384PKCS1_OAEP(keyset.publicKey, msg, useSHA1ForMGF1: cipherMGF1Sha1);
          expect(ct, isNotNull, reason: ctNotNullReason);
          dt = rsa.decryptSHA384PKCS1_OAEP(keyset.privateKey, ct!, useSHA1ForMGF1: cipherMGF1Sha1);
        default:
          throw Exception("Unknow cipherSha ${cipherSha["name"]}");
      }
    case "SHA-512":
      switch(cipherPadding) {
        case "NO_PADDING":
          ct = rsa.encryptSHA512NoPadding(keyset.publicKey, msg);
          expect(ct, isNotNull, reason: ctNotNullReason);
          dt = rsa.decryptSHA512NoPadding(keyset.privateKey, ct!);
        case "PKCS1":
          ct = rsa.encryptSHA512PKCS1(keyset.publicKey, msg);
          expect(ct, isNotNull, reason: ctNotNullReason);
          dt = rsa.decryptSHA512PKCS1(keyset.privateKey, ct!);
        case "PKCS1_OAEP":
          ct = rsa.encryptSHA512PKCS1_OAEP(keyset.publicKey, msg, useSHA1ForMGF1: cipherMGF1Sha1);
          expect(ct, isNotNull, reason: ctNotNullReason);
          dt = rsa.decryptSHA512PKCS1_OAEP(keyset.privateKey, ct!, useSHA1ForMGF1: cipherMGF1Sha1);
        default:
          throw Exception("Unknow cipherSha ${cipherSha["name"]}");
      }
    case "SHA-512_256":
      switch(cipherPadding) {
        case "NO_PADDING":
          ct = rsa.encryptSHA512_256NoPadding(keyset.publicKey, msg);
          expect(ct, isNotNull, reason: ctNotNullReason);
          dt = rsa.decryptSHA512_256NoPadding(keyset.privateKey, ct!);
        case "PKCS1":
          ct = rsa.encryptSHA512_256PKCS1(keyset.publicKey, msg);
          expect(ct, isNotNull, reason: ctNotNullReason);
          dt = rsa.decryptSHA512_256PKCS1(keyset.privateKey, ct!);
        case "PKCS1_OAEP":
          ct = rsa.encryptSHA512_256PKCS1_OAEP(keyset.publicKey, msg, useSHA1ForMGF1: cipherMGF1Sha1);
          expect(ct, isNotNull, reason: ctNotNullReason);
          dt = rsa.decryptSHA512_256PKCS1_OAEP(keyset.privateKey, ct!, useSHA1ForMGF1: cipherMGF1Sha1);
        default:
          throw Exception("Unknow cipherSha ${cipherSha["name"]}");
      }
    default:
      throw Exception("Unknow cipherSha ${cipherSha["name"]}");
  }

  expect(dt, isNotNull, reason: "Expected decrypted text not to be null");
  dt!;
  expect(dt, equals(msg), reason: "Expected decrypted text to match original message. msg: ${hex.encode(msg)} dt: ${hex.encode(dt)}");

  List<int>? sig;
  List<int>? digest;
  bool? ok;
  final sigNotNullReason = "Expected signature shouldn't be null. keyset.privateKey: ${hex.encode(keyset.privateKey)}";
  switch (sigSha["name"]) {
    case "SHA-1":
      digest = sha1.hash(msg);
      digest!;
      switch(sigPadding) {
        case "PKCS1":
          sig = rsa.signSHA1DigestPKCS1(keyset.privateKey, digest);
          expect(sig, isNotNull, reason: sigNotNullReason);
          ok = rsa.verifySHA1DigestPKCS1(keyset.publicKey, digest, sig!);
        case "PKCS1_PSS":
          sig = rsa.signSHA1DigestPKCS1_PSS(keyset.privateKey, digest);
          expect(sig, isNotNull, reason: sigNotNullReason);
          ok = rsa.verifySHA1DigestPKCS1_PSS(keyset.publicKey, digest, sig!);
        default:
          throw Exception("Unknow sigPadding $sigPadding");
      }
    case "SHA-224":
      digest = sha224.hash(msg);
      digest!;
      switch(sigPadding) {
        case "PKCS1":
          sig = rsa.signSHA224DigestPKCS1(keyset.privateKey, digest);
          expect(sig, isNotNull, reason: sigNotNullReason);
          ok = rsa.verifySHA224DigestPKCS1(keyset.publicKey, digest, sig!);
        case "PKCS1_PSS":
          sig = rsa.signSHA224DigestPKCS1_PSS(keyset.privateKey, digest);
          expect(sig, isNotNull, reason: sigNotNullReason);
          ok = rsa.verifySHA224DigestPKCS1_PSS(keyset.publicKey, digest, sig!);
        default:
          throw Exception("Unknow sigPadding $sigPadding");
      }
    case "SHA-256":
      digest = sha256.hash(msg);
      digest!;
      switch(sigPadding) {
        case "PKCS1":
          sig = rsa.signSHA256DigestPKCS1(keyset.privateKey, digest);
          expect(sig, isNotNull, reason: sigNotNullReason);
          ok = rsa.verifySHA256DigestPKCS1(keyset.publicKey, digest, sig!);
        case "PKCS1_PSS":
          sig = rsa.signSHA256DigestPKCS1_PSS(keyset.privateKey, digest);
          expect(sig, isNotNull, reason: sigNotNullReason);
          ok = rsa.verifySHA256DigestPKCS1_PSS(keyset.publicKey, digest, sig!);
        default:
          throw Exception("Unknow sigPadding $sigPadding");
      }
    case "SHA-384":
      digest = sha384.hash(msg);
      digest!;
      switch(sigPadding) {
        case "PKCS1":
          sig = rsa.signSHA384DigestPKCS1(keyset.privateKey, digest);
          expect(sig, isNotNull, reason: sigNotNullReason);
          ok = rsa.verifySHA384DigestPKCS1(keyset.publicKey, digest, sig!);
        case "PKCS1_PSS":
          sig = rsa.signSHA384DigestPKCS1_PSS(keyset.privateKey, digest);
          expect(sig, isNotNull, reason: sigNotNullReason);
          ok = rsa.verifySHA384DigestPKCS1_PSS(keyset.publicKey, digest, sig!);
        default:
          throw Exception("Unknow sigPadding $sigPadding");
      }
    case "SHA-512":
      digest = sha512.hash(msg);
      digest!;
      switch(sigPadding) {
        case "PKCS1":
          sig = rsa.signSHA512DigestPKCS1(keyset.privateKey, digest);
          expect(sig, isNotNull, reason: sigNotNullReason);
          ok = rsa.verifySHA512DigestPKCS1(keyset.publicKey, digest, sig!);
        case "PKCS1_PSS":
          sig = rsa.signSHA512DigestPKCS1_PSS(keyset.privateKey, digest);
          expect(sig, isNotNull, reason: sigNotNullReason);
          ok = rsa.verifySHA512DigestPKCS1_PSS(keyset.publicKey, digest, sig!);
        default:
          throw Exception("Unknow sigPadding $sigPadding");
      }
    case "SHA-512_256":
      digest = sha512_256.hash(msg);
      digest!;
      switch(sigPadding) {
        case "PKCS1":
          sig = rsa.signSHA512_256DigestPKCS1(keyset.privateKey, digest);
          expect(sig, isNotNull, reason: sigNotNullReason);
          ok = rsa.verifySHA512_256DigestPKCS1(keyset.publicKey, digest, sig!);
        case "PKCS1_PSS":
          sig = rsa.signSHA512_256DigestPKCS1_PSS(keyset.privateKey, digest);
          expect(sig, isNotNull, reason: sigNotNullReason);
          ok = rsa.verifySHA512_256DigestPKCS1_PSS(keyset.publicKey, digest, sig!);
        default:
          throw Exception("Unknow sigPadding $sigPadding");
      }
    default:
      throw Exception("Unknow sigSha ${sigSha["name"]}");
  }

  expect(ok, isNotNull);
  ok!;
  expect(ok, equals(true));
}

List<int> _getMessage(String msgType, int bits, String pad, int cSHABytes) {
  // 1. Calculate the absolute max boundary
  final keyBytes = bits ~/ 8;
  int maxLen = 0;

  if (pad == "NO_PADDING") {
    maxLen = keyBytes;
  } else if (pad == "PKCS1") {
    maxLen = keyBytes - 11;
  } else if (pad == "PKCS1_OAEP") {
    final hashBytes = cSHABytes;
    maxLen = keyBytes - (2 * hashBytes) - 2;
  }

  // 2. Route the generation
  List<int> msgRaw;
  switch (msgType) {
    case "CM_0":
      msgRaw = [];
    case "CM_8":
      msgRaw = hex.decode("0001020304050607");
    case "RM_4":
      msgRaw = _generateRandomBytes(4);
    case "RM_16":
      msgRaw = _generateRandomBytes(16);
    case "RM_MAX":
      msgRaw = _generateRandomBytes(maxLen);
      msgRaw[0] = 0;
    case "RL_1-8":
      msgRaw = _generateRandomBytes(_randomInt(1, 8));
    case "RL_8-16":
      msgRaw = _generateRandomBytes(_randomInt(8, 16));
    default:
      throw Exception("Unknown msgType: $msgType");
  }

  final msg = pad == "NO_PADDING"
  ? [...List.filled((bits ~/ 8)-msgRaw.length, 0), ...msgRaw]
  : msgRaw;
  return msg.length > maxLen ? msg.sublist(0, maxLen) : msg;
}

List<int> _generateRandomBytes(int length) {
  final rand = Random.secure();
  return List.generate(length, (_)=>rand.nextInt(256));
}

int _randomInt(int min, int max) {
  final rand = Random.secure();
  return rand.nextInt((max - min) + 1) + min;
}