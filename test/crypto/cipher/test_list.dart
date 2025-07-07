import '../../make_test/make_test_func.dart';

import 'test_vector/aead_aes_gcm_tv.dart' as aead_aes_gcm_tv;
import 'test_vector/aead_aes_gcm_nist_tv.dart' as aead_aes_gcm_nist_tv;
import 'test_vector/aead_chacha20_poly1305_tv.dart' as aead_chacha20_poly1305_tv;
import 'test_vector/aead_xchacha20_poly1305_tv.dart' as aead_xchacha20_poly1305_tv;
import 'test_vector/aead_aes_crt_hmac_sha256_tv.dart' as aead_aes_crt_hmac_sha256_tv;
import 'test_vector/aead_aes_gcm_siv_tv.dart' as aead_aes_gcm_siv_tv;
import 'test_vector/aead_aes_gcm_randnonce_tv.dart' as aead_aes_gcm_randnonce_tv;
import 'test_vector/aead_aes_ccm_bluetooth_tv.dart' as aead_aes_ccm_bluetooth_tv;
import 'test_vector/aead_aes_ccm_bluetooth8_tv.dart' as aead_aes_ccm_bluetooth8_tv;
import 'test_vector/aead_aes_ccm_matter_tv.dart' as aead_aes_ccm_matter_tv;
import 'test_vector/aead_aes_eax_tv.dart' as aead_aes_eax_tv;
import 'test_vector/aes_cbc_tv.dart' as aes_cbc_tv;
import 'test_vector/aes_cfb_tv.dart' as aes_cfb_tv;
import 'test_vector/aes_crt_tv.dart' as aes_crt_tv;
import 'test_vector/aes_ecb_tv.dart' as aes_ecb_tv;
import 'test_vector/aes_ofb_tv.dart' as aes_ofb_tv;
import 'test_vector/chacha20_tv.dart' as chacha20_tv;


import 'tests/aead_aes_gcm_seal.dart' as aead_aes_gcm_seal;
import 'tests/aead_aes_gcm_open.dart' as aead_aes_gcm_open;
import 'tests/aead_chacha20_poly1305_seal.dart' as aead_chacha20_poly1305_seal;
import 'tests/aead_chacha20_poly1305_open.dart' as aead_chacha20_poly1305_open;
import 'tests/aead_xchacha20_poly1305_seal.dart' as aead_xchacha20_poly1305_seal;
import 'tests/aead_xchacha20_poly1305_open.dart' as aead_xchacha20_poly1305_open;
import 'tests/aead_aes_crt_hmac_sha256_seal.dart' as aead_aes_crt_hmac_sha256_seal;
import 'tests/aead_aes_crt_hmac_sha256_open.dart' as aead_aes_crt_hmac_sha256_open;
import 'tests/aead_aes_gcm_siv_seal.dart' as aead_aes_gcm_siv_seal;
import 'tests/aead_aes_gcm_siv_open.dart' as aead_aes_gcm_siv_open;
import 'tests/aead_aes_gcm_randnonce_seal.dart' as aead_aes_gcm_randnonce_seal;
import 'tests/aead_aes_gcm_randnonce_open.dart' as aead_aes_gcm_randnonce_open;
import 'tests/aead_aes_ccm_bluetooth_seal.dart' as aead_aes_ccm_bluetooth_seal;
import 'tests/aead_aes_ccm_bluetooth_open.dart' as aead_aes_ccm_bluetooth_open;
import 'tests/aead_aes_ccm_bluetooth8_seal.dart' as aead_aes_ccm_bluetooth8_seal;
import 'tests/aead_aes_ccm_bluetooth8_open.dart' as aead_aes_ccm_bluetooth8_open;
import 'tests/aead_aes_ccm_matter_seal.dart' as aead_aes_ccm_matter_seal;
import 'tests/aead_aes_ccm_matter_open.dart' as aead_aes_ccm_matter_open;
import 'tests/aead_aes_eax_seal.dart' as aead_aes_eax_seal;
import 'tests/aead_aes_eax_open.dart' as aead_aes_eax_open;
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
    aead_aes_gcm_seal.testFunc,
    testVectorFilter: (sample) => !sample.containsKey("NO_SEAL"),
  ),
  makeTest(
    "AEAD AES GCM seal NIST",
    aead_aes_gcm_nist_tv.testVectorsStr,
    aead_aes_gcm_seal.testFunc,
    testVectorFilter: (sample) => !sample.containsKey("NO_SEAL"),
    tags: ["no-tdd"],
  ),
  makeTest(
    "AEAD AES GCM open",
    aead_aes_gcm_tv.testVectorsStr,
    aead_aes_gcm_open.testFunc,
  ),
  makeTest(
    "AEAD ChaCha20Poly1305 seal",
    aead_chacha20_poly1305_tv.testVectorsStr,
    aead_chacha20_poly1305_seal.testFunc,
    testVectorFilter: (sample) => !sample.containsKey("NO_SEAL"),
  ),
  makeTest(
    "AEAD ChaChaPoly1305 open",
    aead_chacha20_poly1305_tv.testVectorsStr,
    aead_chacha20_poly1305_open.testFunc,
  ),
  makeTest(
    "AEAD XChaCha20Poly1305 seal",
    aead_xchacha20_poly1305_tv.testVectorsStr,
    aead_xchacha20_poly1305_seal.testFunc,
    testVectorFilter: (sample) => !sample.containsKey("NO_SEAL"),
  ),
  makeTest(
    "AEAD XChaChaPoly1305 open",
    aead_xchacha20_poly1305_tv.testVectorsStr,
    aead_xchacha20_poly1305_open.testFunc,
  ),
  makeTest(
    "AEAD CRT HMAC SHA256 seal",
    aead_aes_crt_hmac_sha256_tv.testVectorsStr,
    aead_aes_crt_hmac_sha256_seal.testFunc,
    testVectorFilter: (sample) => !sample.containsKey("NO_SEAL"),
  ),
  makeTest(
    "AEAD AES CRT HMAC SHA256 open",
    aead_aes_crt_hmac_sha256_tv.testVectorsStr,
    aead_aes_crt_hmac_sha256_open.testFunc,
  ),
  makeTest(
    "AEAD GCM SIV seal",
    aead_aes_gcm_siv_tv.testVectorsStr,
    aead_aes_gcm_siv_seal.testFunc,
    testVectorFilter: (sample) => !sample.containsKey("NO_SEAL"),
  ),
  makeTest(
    "AEAD AES GCM SIV open",
    aead_aes_gcm_siv_tv.testVectorsStr,
    aead_aes_gcm_siv_open.testFunc,
  ),
  makeTest(
    "AEAD GCM RandNonce seal",
    aead_aes_gcm_randnonce_tv.testVectorsStr,
    aead_aes_gcm_randnonce_seal.testFunc,
    testVectorFilter: (sample) => !sample.containsKey("NO_SEAL"),
  ),
  makeTest(
    "AEAD AES GCM RandNonce open",
    aead_aes_gcm_randnonce_tv.testVectorsStr,
    aead_aes_gcm_randnonce_open.testFunc,
  ),
  makeTest(
    "AEAD AES CCM Bluetooth seal",
    aead_aes_ccm_bluetooth_tv.testVectorsStr,
    aead_aes_ccm_bluetooth_seal.testFunc,
    testVectorFilter: (sample) => !sample.containsKey("NO_SEAL"),
  ),
  makeTest(
    "AEAD AES CCM Bluetooth open",
    aead_aes_ccm_bluetooth_tv.testVectorsStr,
    aead_aes_ccm_bluetooth_open.testFunc,
  ),
  makeTest(
    "AEAD AES CCM Bluetooth8 seal",
    aead_aes_ccm_bluetooth8_tv.testVectorsStr,
    aead_aes_ccm_bluetooth8_seal.testFunc,
    testVectorFilter: (sample) => !sample.containsKey("NO_SEAL"),
  ),
  makeTest(
    "AEAD AES CCM Bluetooth8 open",
    aead_aes_ccm_bluetooth8_tv.testVectorsStr,
    aead_aes_ccm_bluetooth8_open.testFunc,
  ),
  makeTest(
    "AEAD AES CCM Matter seal",
    aead_aes_ccm_matter_tv.testVectorsStr,
    aead_aes_ccm_matter_seal.testFunc,
    testVectorFilter: (sample) => !sample.containsKey("NO_SEAL"),
  ),
  makeTest(
    "AEAD AES CCM Matter open",
    aead_aes_ccm_matter_tv.testVectorsStr,
    aead_aes_ccm_matter_open.testFunc,
  ),
  makeTest(
    "AEAD AES EAX seal",
    aead_aes_eax_tv.testVectorsStr,
    aead_aes_eax_seal.testFunc,
    testVectorFilter: (sample) => !sample.containsKey("NO_SEAL"),
  ),
  makeTest(
    "AEAD AES EAX open",
    aead_aes_eax_tv.testVectorsStr,
    aead_aes_eax_open.testFunc,
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
