import 'package:boringssl_ffi/crypto/pkcs/rsa/rsa.dart';

import '../../helpers.dart';
import '../../make_test/make_test_func.dart';

import 'test_vector/rsa_generate_key_tv.dart' as rsa_generate_key_tv;
import 'test_vector/rsa_oaep_2048_sha1_mgf1sha1_tv.dart' as rsa_oaep_2048_sha1_mgf1sha1_tv;
import 'test_vector/rsa_oaep_2048_sha224_mgf1sha1_tv.dart' as rsa_oaep_2048_sha224_mgf1sha1_tv;
import 'test_vector/rsa_oaep_2048_sha224_mgf1sha224_tv.dart' as rsa_oaep_2048_sha224_mgf1sha224_tv;
import 'test_vector/rsa_oaep_2048_sha256_mgf1sha1_tv.dart' as rsa_oaep_2048_sha256_mgf1sha1_tv;
import 'test_vector/rsa_oaep_2048_sha256_mgf1sha256_tv.dart' as rsa_oaep_2048_sha256_mgf1sha256_tv;
import 'test_vector/rsa_oaep_2048_sha384_mgf1sha1_tv.dart' as rsa_oaep_2048_sha384_mgf1sha1_tv;
import 'test_vector/rsa_oaep_2048_sha384_mgf1sha384_tv.dart' as rsa_oaep_2048_sha384_mgf1sha384_tv;
import 'test_vector/rsa_oaep_2048_sha512_mgf1sha1_tv.dart' as rsa_oaep_2048_sha512_mgf1sha1_tv;
import 'test_vector/rsa_oaep_2048_sha512_mgf1sha512_tv.dart' as rsa_oaep_2048_sha512_mgf1sha512_tv;
import 'test_vector/rsa_oaep_3072_sha256_mgf1sha1_tv.dart' as rsa_oaep_3072_sha256_mgf1sha1_tv;
import 'test_vector/rsa_oaep_3072_sha256_mgf1sha256_tv.dart' as rsa_oaep_3072_sha256_mgf1sha256_tv;
import 'test_vector/rsa_oaep_3072_sha512_256_mgf1sha1_tv.dart' as rsa_oaep_3072_sha512_256_mgf1sha1_tv;
import 'test_vector/rsa_oaep_3072_sha512_256_mgf1sha512_256_tv.dart' as rsa_oaep_3072_sha512_256_mgf1sha512_256_tv;
import 'test_vector/rsa_oaep_3072_sha512_mgf1sha1_tv.dart' as rsa_oaep_3072_sha512_mgf1sha1_tv;
import 'test_vector/rsa_oaep_3072_sha512_mgf1sha512_tv.dart' as rsa_oaep_3072_sha512_mgf1sha512_tv;
import 'test_vector/rsa_oaep_4096_sha256_mgf1sha1_tv.dart' as rsa_oaep_4096_sha256_mgf1sha1_tv;
import 'test_vector/rsa_oaep_4096_sha256_mgf1sha256_tv.dart' as rsa_oaep_4096_sha256_mgf1sha256_tv;
import 'test_vector/rsa_oaep_4096_sha512_mgf1sha1_tv.dart' as rsa_oaep_4096_sha512_mgf1sha1_tv;
import 'test_vector/rsa_oaep_4096_sha512_mgf1sha512_tv.dart' as rsa_oaep_4096_sha512_mgf1sha512_tv;
import 'test_vector/rsa_oaep_misc_tv.dart' as rsa_oaep_misc_tv;
import 'test_vector/rsa_pkcs1_1024_sig_gen_tv.dart' as rsa_pkcs1_1024_sig_gen_tv;
import 'test_vector/rsa_pkcs1_1536_sig_gen_tv.dart' as rsa_pkcs1_1536_sig_gen_tv;
import 'test_vector/rsa_pkcs1_2048_sig_gen_tv.dart' as rsa_pkcs1_2048_sig_gen_tv;
import 'test_vector/rsa_pkcs1_2048_tv.dart' as rsa_pkcs1_2048_tv;
import 'test_vector/rsa_pkcs1_3072_sig_gen_tv.dart' as rsa_pkcs1_3072_sig_gen_tv;
import 'test_vector/roundtrip_tv.dart' as roundtrip_tv;



import 'tests/rsa_generate_keyset.dart' as rsa_generate_keyset;
import 'tests/rsa_oaep_2048_sha1_mgf1sha1_decrypt.dart' as rsa_oaep_2048_sha1_mgf1sha1_decrypt;
import 'tests/rsa_oaep_2048_sha224_mgf1sha1_decrypt.dart' as rsa_oaep_2048_sha224_mgf1sha1_decrypt;
import 'tests/rsa_oaep_2048_sha224_mgf1sha224_decrypt.dart' as rsa_oaep_2048_sha224_mgf1sha224_decrypt;
import 'tests/rsa_oaep_2048_sha256_mgf1sha1_decrypt.dart' as rsa_oaep_2048_sha256_mgf1sha1_decrypt;
import 'tests/rsa_oaep_2048_sha256_mgf1sha256_decrypt.dart' as rsa_oaep_2048_sha256_mgf1sha256_decrypt;
import 'tests/rsa_oaep_2048_sha384_mgf1sha1_decrypt.dart' as rsa_oaep_2048_sha384_mgf1sha1_decrypt;
import 'tests/rsa_oaep_2048_sha384_mgf1sha384_decrypt.dart' as rsa_oaep_2048_sha384_mgf1sha384_decrypt;
import 'tests/rsa_oaep_2048_sha512_mgf1sha1_decrypt.dart' as rsa_oaep_2048_sha512_mgf1sha1_decrypt;
import 'tests/rsa_oaep_2048_sha512_mgf1sha512_decrypt.dart' as rsa_oaep_2048_sha512_mgf1sha512_decrypt;
import 'tests/rsa_oaep_3072_sha256_mgf1sha1_decrypt.dart' as rsa_oaep_3072_sha256_mgf1sha1_decrypt;
import 'tests/rsa_oaep_3072_sha256_mgf1sha256_decrypt.dart' as rsa_oaep_3072_sha256_mgf1sha256_decrypt;
import 'tests/rsa_oaep_3072_sha512_256_mgf1sha1_decrypt.dart' as rsa_oaep_3072_sha512_256_mgf1sha1_decrypt;
import 'tests/rsa_oaep_3072_sha512_256_mgf1sha512_256_decrypt.dart' as rsa_oaep_3072_sha512_256_mgf1sha512_256_decrypt;
import 'tests/rsa_oaep_3072_sha512_mgf1sha1_decrypt.dart' as rsa_oaep_3072_sha512_mgf1sha1_decrypt;
import 'tests/rsa_oaep_3072_sha512_mgf1sha512_decrypt.dart' as rsa_oaep_3072_sha512_mgf1sha512_decrypt;
import 'tests/rsa_oaep_4096_sha256_mgf1sha1_decrypt.dart' as rsa_oaep_4096_sha256_mgf1sha1_decrypt;
import 'tests/rsa_oaep_4096_sha256_mgf1sha256_decrypt.dart' as rsa_oaep_4096_sha256_mgf1sha256_decrypt;
import 'tests/rsa_oaep_4096_sha512_mgf1sha1_decrypt.dart' as rsa_oaep_4096_sha512_mgf1sha1_decrypt;
import 'tests/rsa_oaep_4096_sha512_mgf1sha512_decrypt.dart' as rsa_oaep_4096_sha512_mgf1sha512_decrypt;
import 'tests/rsa_oaep_misc_decrypt.dart' as rsa_oaep_misc_decrypt;
import 'tests/rsa_pkcs1_1024_sig_gen_verify.dart' as rsa_pkcs1_1024_sig_gen_verify;
import 'tests/rsa_pkcs1_1536_sig_gen_verify.dart' as rsa_pkcs1_1536_sig_gen_verify;
import 'tests/rsa_pkcs1_2048_sig_gen_verify.dart' as rsa_pkcs1_2048_sig_gen_verify;
import 'tests/rsa_pkcs1_2048_decrypt.dart' as rsa_pkcs1_2048_decrypt;
import 'tests/rsa_pkcs1_3072_sig_gen_verify.dart' as rsa_pkcs1_3072_sig_gen_verify;
import 'tests/roundtrip_round.dart' as roundtrip_round;

final testList = [
  makeTest(
    "RSA GenerateKeys",
    rsa_generate_key_tv.testVectorsStr,
    rsa_generate_keyset.testFunc,
    isJSON: true,
  ),
  makeTest(
    "RSA Decrypt rsa_oaep_2048_sha1_mgf1sha1",
    rsa_oaep_2048_sha1_mgf1sha1_tv.testVectorsStr,
    rsa_oaep_2048_sha1_mgf1sha1_decrypt.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_oaep_2048_sha1_mgf1sha1 {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final privateKey = testGroup["privateKeyPkcs8"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'privKey': privateKey,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Decrypt rsa_oaep_2048_sha224_mgf1sha1",
    rsa_oaep_2048_sha224_mgf1sha1_tv.testVectorsStr,
    rsa_oaep_2048_sha224_mgf1sha1_decrypt.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_oaep_2048_sha224_mgf1sha1 {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final privateKey = testGroup["privateKeyPkcs8"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'privKey': privateKey,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Decrypt rsa_oaep_2048_sha224_mgf1sha224",
    rsa_oaep_2048_sha224_mgf1sha224_tv.testVectorsStr,
    rsa_oaep_2048_sha224_mgf1sha224_decrypt.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_oaep_2048_sha224_mgf1sha224 {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final privateKey = testGroup["privateKeyPkcs8"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'privKey': privateKey,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Decrypt rsa_oaep_2048_sha256_mgf1sha1",
    rsa_oaep_2048_sha256_mgf1sha1_tv.testVectorsStr,
    rsa_oaep_2048_sha256_mgf1sha1_decrypt.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_oaep_2048_sha256_mgf1sha1 {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final privateKey = testGroup["privateKeyPkcs8"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'privKey': privateKey,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Decrypt rsa_oaep_2048_sha256_mgf1sha256",
    rsa_oaep_2048_sha256_mgf1sha256_tv.testVectorsStr,
    rsa_oaep_2048_sha256_mgf1sha256_decrypt.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_oaep_2048_sha256_mgf1sha256 {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final privateKey = testGroup["privateKeyPkcs8"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'privKey': privateKey,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Decrypt rsa_oaep_2048_sha384_mgf1sha1",
    rsa_oaep_2048_sha384_mgf1sha1_tv.testVectorsStr,
    rsa_oaep_2048_sha384_mgf1sha1_decrypt.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_oaep_2048_sha384_mgf1sha1 {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final privateKey = testGroup["privateKeyPkcs8"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'privKey': privateKey,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Decrypt rsa_oaep_2048_sha384_mgf1sha384",
    rsa_oaep_2048_sha384_mgf1sha384_tv.testVectorsStr,
    rsa_oaep_2048_sha384_mgf1sha384_decrypt.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_oaep_2048_sha384_mgf1sha384 {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final privateKey = testGroup["privateKeyPkcs8"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'privKey': privateKey,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Decrypt rsa_oaep_2048_sha512_mgf1sha1",
    rsa_oaep_2048_sha512_mgf1sha1_tv.testVectorsStr,
    rsa_oaep_2048_sha512_mgf1sha1_decrypt.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_oaep_2048_sha512_mgf1sha1 {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final privateKey = testGroup["privateKeyPkcs8"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'privKey': privateKey,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Decrypt rsa_oaep_2048_sha512_mgf1sha512",
    rsa_oaep_2048_sha512_mgf1sha512_tv.testVectorsStr,
    rsa_oaep_2048_sha512_mgf1sha512_decrypt.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_oaep_2048_sha512_mgf1sha512 {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final privateKey = testGroup["privateKeyPkcs8"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'privKey': privateKey,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Decrypt rsa_oaep_3072_sha256_mgf1sha1",
    rsa_oaep_3072_sha256_mgf1sha1_tv.testVectorsStr,
    rsa_oaep_3072_sha256_mgf1sha1_decrypt.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_oaep_3072_sha256_mgf1sha1 {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final privateKey = testGroup["privateKeyPkcs8"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'privKey': privateKey,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Decrypt rsa_oaep_3072_sha256_mgf1sha256",
    rsa_oaep_3072_sha256_mgf1sha256_tv.testVectorsStr,
    rsa_oaep_3072_sha256_mgf1sha256_decrypt.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_oaep_3072_sha256_mgf1sha256 {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final privateKey = testGroup["privateKeyPkcs8"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'privKey': privateKey,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Decrypt rsa_oaep_3072_sha512_256_mgf1sha1",
    rsa_oaep_3072_sha512_256_mgf1sha1_tv.testVectorsStr,
    rsa_oaep_3072_sha512_256_mgf1sha1_decrypt.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_oaep_3072_sha512_256_mgf1sha1 {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final privateKey = testGroup["privateKeyPkcs8"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'privKey': privateKey,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Decrypt rsa_oaep_3072_sha512_256_mgf1sha512_256",
    rsa_oaep_3072_sha512_256_mgf1sha512_256_tv.testVectorsStr,
    rsa_oaep_3072_sha512_256_mgf1sha512_256_decrypt.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_oaep_3072_sha512_256_mgf1sha512_256 {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final privateKey = testGroup["privateKeyPkcs8"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'privKey': privateKey,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Decrypt rsa_oaep_3072_sha512_mgf1sha1",
    rsa_oaep_3072_sha512_mgf1sha1_tv.testVectorsStr,
    rsa_oaep_3072_sha512_mgf1sha1_decrypt.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_oaep_3072_sha512_mgf1sha1 {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final privateKey = testGroup["privateKeyPkcs8"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'privKey': privateKey,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Decrypt rsa_oaep_3072_sha512_mgf1sha512",
    rsa_oaep_3072_sha512_mgf1sha512_tv.testVectorsStr,
    rsa_oaep_3072_sha512_mgf1sha512_decrypt.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_oaep_3072_sha512_mgf1sha512 {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final privateKey = testGroup["privateKeyPkcs8"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'privKey': privateKey,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Decrypt rsa_oaep_4096_sha256_mgf1sha1",
    rsa_oaep_4096_sha256_mgf1sha1_tv.testVectorsStr,
    rsa_oaep_4096_sha256_mgf1sha1_decrypt.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_oaep_4096_sha256_mgf1sha1 {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final privateKey = testGroup["privateKeyPkcs8"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'privKey': privateKey,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Decrypt rsa_oaep_4096_sha256_mgf1sha256",
    rsa_oaep_4096_sha256_mgf1sha256_tv.testVectorsStr,
    rsa_oaep_4096_sha256_mgf1sha256_decrypt.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_oaep_4096_sha256_mgf1sha256 {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final privateKey = testGroup["privateKeyPkcs8"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'privKey': privateKey,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Decrypt rsa_oaep_4096_sha512_mgf1sha1",
    rsa_oaep_4096_sha512_mgf1sha1_tv.testVectorsStr,
    rsa_oaep_4096_sha512_mgf1sha1_decrypt.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_oaep_4096_sha512_mgf1sha1 {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final privateKey = testGroup["privateKeyPkcs8"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'privKey': privateKey,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Decrypt rsa_oaep_4096_sha512_mgf1sha51",
    rsa_oaep_4096_sha512_mgf1sha512_tv.testVectorsStr,
    rsa_oaep_4096_sha512_mgf1sha512_decrypt.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_oaep_4096_sha512_mgf1sha51 {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final privateKey = testGroup["privateKeyPkcs8"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'privKey': privateKey,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Decrypt rsa_oaep_misc",
    rsa_oaep_misc_tv.testVectorsStr,
    rsa_oaep_misc_decrypt.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_oaep_misc {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final privateKey = testGroup["privateKeyPkcs8"];
        final sha = testGroup["sha"];
        final mgfSha = testGroup["mgfSha"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'privKey': privateKey,
            'sha': sha,
            'mgfSha': mgfSha,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Verify rsa_pkcs1_1024_sig_gen_verify",
    rsa_pkcs1_1024_sig_gen_tv.testVectorsStr,
    rsa_pkcs1_1024_sig_gen_verify.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_pkcs1_1024_sig_gen_verify {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final publicKey = testGroup["keyAsn"];
        final sha = testGroup["sha"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'pubKey': publicKey,
            'sha': sha,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Verify rsa_pkcs1_1536_sig_gen_verify",
    rsa_pkcs1_1536_sig_gen_tv.testVectorsStr,
    rsa_pkcs1_1536_sig_gen_verify.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_pkcs1_1536_sig_gen_verify {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final publicKey = testGroup["keyAsn"];
        final sha = testGroup["sha"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'pubKey': publicKey,
            'sha': sha,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Verify rsa_pkcs1_2048_sig_gen_verify",
    rsa_pkcs1_2048_sig_gen_tv.testVectorsStr,
    rsa_pkcs1_2048_sig_gen_verify.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_pkcs1_2048_sig_gen_verify {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final publicKey = testGroup["keyAsn"];
        final sha = testGroup["sha"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'pubKey': publicKey,
            'sha': sha,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Decrypt rsa_pkcs1_2048_decrypt",
    rsa_pkcs1_2048_tv.testVectorsStr,
    rsa_pkcs1_2048_decrypt.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_oaep_2048_sha1_mgf1sha1 {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final privateKey = testGroup["privateKeyPkcs8"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'privKey': privateKey,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Verify rsa_pkcs1_3072_sig_gen_verify",
    rsa_pkcs1_3072_sig_gen_tv.testVectorsStr,
    rsa_pkcs1_3072_sig_gen_verify.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      final baseName = "RSA Decrypt rsa_pkcs1_3072_sig_gen_verify {TYPE} #{COUNTER}";
      final testGroups = obj["testGroups"] as List<dynamic>;
      final List<Map<String, dynamic>> allTests = [];
      for (final testGroup in testGroups){
        final publicKey = testGroup["keyAsn"];
        final sha = testGroup["sha"];
        final expandedTests = (testGroup["tests"] as List<dynamic>).map<Map<String, dynamic>>((v) {
          final testMap = v as Map<String, dynamic>;
          final testName = baseName
            .replaceAll("{COUNTER}", testMap["tcId"].toString())
            .replaceAll("{TYPE}", testGroup["type"]);
          return {
            ...testMap,
            '_name': testName,
            'pubKey': publicKey,
            'sha': sha,
          };
        }).toList();
        allTests.addAll(expandedTests);
      }

      return allTests;
    },
  ),
  makeTest(
    "RSA Roundtrip testing",
    roundtrip_tv.testVectorsStr,
    roundtrip_round.testFunc,
    isJSON: true,
    jsonExtractor: (decodedJson) {
      final obj = decodedJson as Map<String, dynamic>;
      // final baseName = "RSA roundtrip bits: {BITS} FIPS: {FIPS} cSHA: msg: {MSG_TYPE} {CIPHER_SHA} cPad: {CIPHER_PAD} cMFTG1: {MFTG1} sSHA: {SIG_SHA} sPad: {SIG_PAD}";
      final keySizesBits = (obj["keySizesBits"] as List<dynamic>).map<int>((v)=>v);
      final fips = (obj["fips"] as List<dynamic>).map<bool>((v)=>v);
      final hashes = (obj["hashes"] as List<dynamic>).map<Map<String, dynamic>>((v)=>v as Map<String, dynamic>).toList();
      final cipherPaddings = (obj["cipherPaddings"] as List<dynamic>).map<String>((v)=>v);
      final sigPaddings = (obj["sigPaddings"] as List<dynamic>).map<String>((v)=>v);

      List<Map<String, dynamic>> _getHashes(List<Map<String, dynamic>> hashes, int bits, String pad, {required bool isSig}) {
        // If it's NO_PADDING, or PKCS1 ENCRYPTION, hash size doesn't matter.
        if (pad == "NO_PADDING" || (pad == "PKCS1" && !isSig)) {
          return hashes;
        }

        final keyBytes = bits ~/ 8;
        return hashes.where((sha) {
          final hashBytes = sha["bytes"] as int;
          
          if (isSig && pad == "PKCS1") {
            // BoringSSL lacks the hardcoded ASN.1 DigestInfo prefix for SHA-512_256 in PKCS#1 v1.5
            if (sha["name"] == "SHA-512_256") return false;

            // PKCS#1 v1.5 Signatures require: ~19 bytes ASN.1 + 11 bytes padding + hash size
            return keyBytes >= (hashBytes + 30);
          } else {
            // OAEP and PSS mathematical limit requirement:
            return keyBytes >= (2 * hashBytes + 2);
          }
        }).toList();
      }

      final List<Map<String, dynamic>> allTests = [];
      bool randomKey;
      for (final isFIPS in fips) {
        for (final bits in isFIPS ? [2048, 3072] : keySizesBits){
          final keyset = isFIPS ? rsa.generateKeySetFIPS(bits) : rsa.generateKeySet(bits);
          keyset!;
          randomKey = true;
          for (final cPAD in cipherPaddings) {
            for (final cSHA in _getHashes(hashes, bits, cPAD, isSig: false)) {
              for (final mgf1Sha1 in ((cPAD == "PKCS1_OAEP" && cSHA["name"] != "SHA-1") ? [true, false] : [false])) {
                for (final msgType in ["CM_8", "CM_0", "RM_4", "RM_16", "RM_MAX", "RL_1-8", "RL_8-16"]) {
                  for (final sPAD in sigPaddings) {
                    for (final sSHA in _getHashes(hashes, bits, sPAD, isSig:true)) {
                      allTests.add({
                        "_name": "RSA roundtrip bits: $bits PIFS: $isFIPS msgType: $msgType cPad: $cPAD cSHA: ${cSHA['name']} cMGF1: $mgf1Sha1 sPad: $sPAD sSHA: ${sSHA['name']}",
                        "bits": bits,
                        "fips": isFIPS,
                        "msgType": msgType,
                        "cipherPadding": cPAD,
                        "cipherSha": cSHA,
                        "cipherMGF1Sha1": mgf1Sha1,
                        "sigPadding": sPAD,
                        "sigSha": sSHA,
                        "randomKey": randomKey,
                        "privateKey": hex.encode(keyset.privateKey),
                        "publicKey": hex.encode(keyset.publicKey),
                      });
                      randomKey = false;
                    }
                  }
                }
              }
            }
          }
        }
      }
      return allTests;
    },
  ),
];
