import '../../make_test/make_test_func.dart';

import 'test_vector/sha_tv.dart' as sha_tv;
import 'test_vector/sha512_256_tv.dart' as sha512_256_tv;
import 'test_vector/hmac_sha_tv.dart' as hmac_sha_tv;
import 'test_vector/hmac_sha512_256_tv.dart' as hmac_sha512_256_tv;

import 'tests/sha1_hash.dart' as sha1_hash;
import 'tests/sha224_hash.dart' as sha224_hash;
import 'tests/sha256_hash.dart' as sha256_hash;
import 'tests/sha384_hash.dart' as sha384_hash;
import 'tests/sha512_hash.dart' as sha512_hash;
import 'tests/sha512_256_hash.dart' as sha512_256_hash;
import 'tests/hmac_sha1_hash.dart' as hmac_sha1_hash;
import 'tests/hmac_sha224_hash.dart' as hmac_sha224_hash;
import 'tests/hmac_sha256_hash.dart' as hmac_sha256_hash;
import 'tests/hmac_sha384_hash.dart' as hmac_sha384_hash;
import 'tests/hmac_sha512_hash.dart' as hmac_sha512_hash;
import 'tests/hmac_sha512_256_hash.dart' as hmac_sha512_256_hash;

final testList = [
  makeTest(
    "SHA1 hash",
    sha_tv.testVectorsStr,
    sha1_hash.testFunc,
    testVectorFilter: (sample) => sample["L"] == "20",
    keyValueSeparator: "=",
  ),
  makeTest(
    "SHA224 hash",
    sha_tv.testVectorsStr,
    sha224_hash.testFunc,
    testVectorFilter: (sample) => sample["L"] == "28",
    keyValueSeparator: "=",
  ),
  makeTest(
    "SHA256 hash",
    sha_tv.testVectorsStr,
    sha256_hash.testFunc,
    testVectorFilter: (sample) => sample["L"] == "32",
    keyValueSeparator: "=",
  ),
  makeTest(
    "SHA384 hash",
    sha_tv.testVectorsStr,
    sha384_hash.testFunc,
    testVectorFilter: (sample) => sample["L"] == "48",
    keyValueSeparator: "=",
  ),
  makeTest(
    "SHA512 hash",
    sha_tv.testVectorsStr,
    sha512_hash.testFunc,
    testVectorFilter: (sample) => sample["L"] == "64",
    keyValueSeparator: "=",
  ),
  makeTest(
    "SHA512/256 hash",
    sha512_256_tv.testVectorsStr,
    sha512_256_hash.testFunc,
    keyValueSeparator: "=",
  ),
  makeTest(
    "HMAC SHA1 hash",
    hmac_sha_tv.testVectorsStr,
    hmac_sha1_hash.testFunc,
    testVectorFilter: (sample) => sample["L"] == "20",
    keyValueSeparator: "=",
  ),
  makeTest(
    "HMAC SHA224 hash",
    hmac_sha_tv.testVectorsStr,
    hmac_sha224_hash.testFunc,
    testVectorFilter: (sample) => sample["L"] == "28",
    keyValueSeparator: "=",
  ),
  makeTest(
    "HMAC SHA256 hash",
    hmac_sha_tv.testVectorsStr,
    hmac_sha256_hash.testFunc,
    testVectorFilter: (sample) => sample["L"] == "32",
    keyValueSeparator: "=",
  ),
  makeTest(
    "HMAC SHA384 hash",
    hmac_sha_tv.testVectorsStr,
    hmac_sha384_hash.testFunc,
    testVectorFilter: (sample) => sample["L"] == "48",
    keyValueSeparator: "=",
  ),
  makeTest(
    "HMAC SHA512 hash",
    hmac_sha_tv.testVectorsStr,
    hmac_sha512_hash.testFunc,
    testVectorFilter: (sample) => sample["L"] == "64",
    keyValueSeparator: "=",
  ),
  makeTest(
    "HMAC SHA512/256 hash",
    hmac_sha512_256_tv.testVectorsStr,
    hmac_sha512_256_hash.testFunc,
    keyValueSeparator: "=",
  ),
];
