import '../../make_test/make_test_func.dart';

import 'test_vector/pbkdf2_hmac_sha1_tv.dart' as pbkdf2_hmac_sha1_tv;
import 'test_vector/pbkdf2_hmac_sha224_tv.dart' as pbkdf2_hmac_sha224_tv;
import 'test_vector/pbkdf2_hmac_sha256_tv.dart' as pbkdf2_hmac_sha256_tv;
import 'test_vector/pbkdf2_hmac_sha384_tv.dart' as pbkdf2_hmac_sha384_tv;
import 'test_vector/pbkdf2_hmac_sha512_tv.dart' as pbkdf2_hmac_sha512_tv;
import 'test_vector/pbkdf2_hmac_sha512_256_tv.dart' as pbkdf2_hmac_sha512_256_tv;
import 'test_vector/hkdf_sha1_tv.dart' as hkdf_sha1_tv;
import 'test_vector/hkdf_sha224_tv.dart' as hkdf_sha224_tv;
import 'test_vector/hkdf_sha256_tv.dart' as hkdf_sha256_tv;
import 'test_vector/hkdf_sha384_tv.dart' as hkdf_sha384_tv;
import 'test_vector/hkdf_sha512_tv.dart' as hkdf_sha512_tv;
import 'test_vector/hkdf_sha512_256_tv.dart' as hkdf_sha512_256_tv;

import 'tests/pbkdf2_hmac_sha1_derive.dart' as pbkdf2_hmac_sha1_derive;
import 'tests/pbkdf2_hmac_sha224_derive.dart' as pbkdf2_hmac_sha224_derive;
import 'tests/pbkdf2_hmac_sha256_derive.dart' as pbkdf2_hmac_sha256_derive;
import 'tests/pbkdf2_hmac_sha384_derive.dart' as pbkdf2_hmac_sha384_derive;
import 'tests/pbkdf2_hmac_sha512_derive.dart' as pbkdf2_hmac_sha512_derive;
import 'tests/pbkdf2_hmac_sha512_256_derive.dart' as pbkdf2_hmac_sha512_256_derive;
import 'tests/hkdf_sha1_derive.dart' as hkdf_sha1_derive;
import 'tests/hkdf_sha224_derive.dart' as hkdf_sha224_derive;
import 'tests/hkdf_sha256_derive.dart' as hkdf_sha256_derive;
import 'tests/hkdf_sha384_derive.dart' as hkdf_sha384_derive;
import 'tests/hkdf_sha512_derive.dart' as hkdf_sha512_derive;
import 'tests/hkdf_sha512_256_derive.dart' as hkdf_sha512_256_derive;

final testList = [
  makeTest(
    "PBKDF2 HMAC SHA1 derive",
    pbkdf2_hmac_sha1_tv.testVectorsStr,
    pbkdf2_hmac_sha1_derive.testFunc,
    isJSON: true,
  ),
  makeTest(
    "PBKDF2 HMAC SHA224 derive",
    pbkdf2_hmac_sha224_tv.testVectorsStr,
    pbkdf2_hmac_sha224_derive.testFunc,
    isJSON: true,
  ),
  makeTest(
    "PBKDF2 HMAC SHA256 derive",
    pbkdf2_hmac_sha256_tv.testVectorsStr,
    pbkdf2_hmac_sha256_derive.testFunc,
    isJSON: true,
  ),
  makeTest(
    "PBKDF2 HMAC SHA384 derive",
    pbkdf2_hmac_sha384_tv.testVectorsStr,
    pbkdf2_hmac_sha384_derive.testFunc,
    isJSON: true,
  ),
  makeTest(
    "PBKDF2 HMAC SHA512 derive",
    pbkdf2_hmac_sha512_tv.testVectorsStr,
    pbkdf2_hmac_sha512_derive.testFunc,
    isJSON: true,
  ),
  makeTest(
    "PBKDF2 HMAC SHA512/256 derive",
    pbkdf2_hmac_sha512_256_tv.testVectorsStr,
    pbkdf2_hmac_sha512_256_derive.testFunc,
    isJSON: true,
  ),
  makeTest(
    "HKDF SHA1 derive",
    hkdf_sha1_tv.testVectorsStr,
    hkdf_sha1_derive.testFunc,
    isJSON: true,
  ),
  makeTest(
    "HKDF SHA224 derive",
    hkdf_sha224_tv.testVectorsStr,
    hkdf_sha224_derive.testFunc,
    isJSON: true,
  ),
  makeTest(
    "HKDF SHA256 derive",
    hkdf_sha256_tv.testVectorsStr,
    hkdf_sha256_derive.testFunc,
    isJSON: true,
  ),
  makeTest(
    "HKDF SHA384 derive",
    hkdf_sha384_tv.testVectorsStr,
    hkdf_sha384_derive.testFunc,
    isJSON: true,
  ),
  makeTest(
    "HKDF SHA512 derive",
    hkdf_sha512_tv.testVectorsStr,
    hkdf_sha512_derive.testFunc,
    isJSON: true,
  ),
  makeTest(
    "HKDF SHA512/256 derive",
    hkdf_sha512_256_tv.testVectorsStr,
    hkdf_sha512_256_derive.testFunc,
    isJSON: true,
  ),
];
