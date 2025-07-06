import '../../make_test/make_test_func.dart';

import 'test_vector/aead_aes_gcm_tv.dart' as aead_aes_gcm_tv;
import 'test_vector/aead_aes_gcm_nist_tv.dart' as aead_aes_gcm_nist_tv;
import 'test_vector/aes_cbc_tv.dart' as aes_cbc_tv;
import 'test_vector/aes_cfb_tv.dart' as aes_cfb_tv;
import 'test_vector/aes_crt_tv.dart' as aes_crt_tv;
import 'test_vector/aes_ecb_tv.dart' as aes_ecb_tv;
import 'test_vector/aes_ofb_tv.dart' as aes_ofb_tv;
import 'test_vector/chacha20_tv.dart' as chacha20_tv;

import 'tests/aead_aes_gcm_seal.dart' as aead_aes_gcm;
import 'tests/aes_cbc_encrypt.dart' as aes_cbc_encrypt;
import 'tests/aes_cbc_decrypt.dart' as aes_cbc_decrypt;
import 'tests/aes_cfb_encrypt.dart' as aes_cfb_encrypt;
import 'tests/aes_cfb_decrypt.dart' as aes_cfb_decrypt;
import 'tests/aes_crt_encrypt.dart' as aes_crt_encrypt;
import 'tests/aes_crt_decrypt.dart' as aes_crt_decrypt;
import 'tests/aes_ecb_encrypt.dart' as aes_ecb_encrypt;
import 'tests/aes_ecb_decrypt.dart' as aes_ecb_decrypt;
import 'tests/aes_ofb_encrypt.dart' as aes_ofb_encrypt;
import 'tests/aes_ofb_decrypt.dart' as aes_ofb_decrypt;
import 'tests/chacha20_encrypt.dart' as chacha20_encrypt;
import 'tests/chacha20_decrypt.dart' as chacha20_decrypt;

final testList = [
  makeTest(
    "AEAD AES GCM seal",
    aead_aes_gcm_tv.testVectorsStr,
    aead_aes_gcm.testFunc,
    testVectorFilter: (sample) => !sample.containsKey("NO_SEAL"),
  ),
  makeTest(
    "AEAD AES GCM seal NIST",
    aead_aes_gcm_nist_tv.testVectorsStr,
    aead_aes_gcm.testFunc,
    testVectorFilter: (sample) => !sample.containsKey("NO_SEAL"),
    tags: ["no-tdd"],
  ),
  makeTest(
    "AES CBC NIST encrypt",
    aes_cbc_tv.testVectorsStr,
    aes_cbc_encrypt.testFunc,
    testVectorFilter: (sample) => sample["Operation"] == "ENCRYPT",
    testVectorModifier: (sample) {
      sample["_name"] = "${sample["Cipher"]} - ${sample["_name"]}";
      return sample;
    },
  ),
  makeTest(
    "AES CBC NIST decrypt",
    aes_cbc_tv.testVectorsStr,
    aes_cbc_decrypt.testFunc,
    testVectorFilter: (sample) => sample["Operation"] == "DECRYPT",
    testVectorModifier: (sample) {
      sample["_name"] = "${sample["Cipher"]} - ${sample["_name"]}";
      return sample;
    },
  ),
  makeTest(
    "AES CFB NIST encrypt",
    aes_cfb_tv.testVectorsStr,
    aes_cfb_encrypt.testFunc,
    testVectorFilter: (sample) => sample["Operation"] == "ENCRYPT",
    keyValueSeparator: "=",
    unnamedTagKey: "Operation"
  ),
  makeTest(
    "AES CFB NIST decrypt",
    aes_cfb_tv.testVectorsStr,
    aes_cfb_decrypt.testFunc,
    keyValueSeparator: "=",
    testVectorFilter: (sample) => sample["Operation"] == "DECRYPT",
    unnamedTagKey: "Operation"
  ),
  makeTest(
    "AES CRT NIST encrypt",
    aes_crt_tv.testVectorsStr,
    aes_crt_encrypt.testFunc,
    testVectorFilter: (sample) => sample["Operation"] == "ENCRYPT",
    testVectorModifier: (sample) {
      sample["_name"] = "${sample["Cipher"]} - ${sample["_name"]}";
      return sample;
    },
  ),
  makeTest(
    "AES CRT NIST decrypt",
    aes_crt_tv.testVectorsStr,
    aes_crt_decrypt.testFunc,
    testVectorFilter: (sample) => sample["Operation"] == "DECRYPT",
    testVectorModifier: (sample) {
      sample["_name"] = "${sample["Cipher"]} - ${sample["_name"]}";
      return sample;
    },
  ),
  makeTest(
    "AES ECB NIST encrypt",
    aes_ecb_tv.testVectorsStr,
    aes_ecb_encrypt.testFunc,
    testVectorFilter: (sample) => sample["Operation"] == "ENCRYPT",
    keyValueSeparator: "=",
    unnamedTagKey: "Operation"
  ),
  makeTest(
    "AES ECB NIST decrypt",
    aes_ecb_tv.testVectorsStr,
    aes_ecb_decrypt.testFunc,
    keyValueSeparator: "=",
    testVectorFilter: (sample) => sample["Operation"] == "DECRYPT",
    unnamedTagKey: "Operation"
  ),
  makeTest(
    "AES OFB NIST encrypt",
    aes_ofb_tv.testVectorsStr,
    aes_ofb_encrypt.testFunc,
    testVectorFilter: (sample) => sample["Operation"] == "ENCRYPT",
    keyValueSeparator: "=",
    unnamedTagKey: "Operation"
  ),
  makeTest(
    "AES OFB NIST decrypt",
    aes_ofb_tv.testVectorsStr,
    aes_ofb_decrypt.testFunc,
    keyValueSeparator: "=",
    testVectorFilter: (sample) => sample["Operation"] == "DECRYPT",
    unnamedTagKey: "Operation"
  ),
  makeTest(
    "ChaCha20 encrypt",
    chacha20_tv.testVectorsStr,
    chacha20_encrypt.testFunc,
    testVectorFilter: (sample) => sample["Operation"] == "ENCRYPT",
    testVectorModifier: (sample) {
      sample["_name"] = "${sample["Cipher"]} - ${sample["_name"]}";
      sample["Counter"] = int.parse(sample["Counter"]);
      return sample;
    },
  ),
  makeTest(
    "ChaCha20 decrypt",
    chacha20_tv.testVectorsStr,
    chacha20_decrypt.testFunc,
    testVectorFilter: (sample) => sample["Operation"] == "DECRYPT",
    testVectorModifier: (sample) {
      sample["_name"] = "${sample["Cipher"]} - ${sample["_name"]}";
      sample["Counter"] = int.parse(sample["Counter"]);
      return sample;
    },
  ),
];
