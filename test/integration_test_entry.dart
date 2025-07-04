// ~/workspace/boringssl_ffi/integration_test/boringssl_ffi_integration_test.dart
import 'package:integration_test/integration_test.dart'; // Import this
import 'package:boringssl_ffi/src/logging/logging.dart';
import 'package:logging/logging.dart' as logging_pkg;
import '../grill_testing/grill_group.dart';
import 'crypto/hash/sha1/sha1_test.dart' as sha1_test;
import 'crypto/hash/sha224/sha224_test.dart' as sha224_test;
import 'crypto/hash/sha256/sha256_test.dart' as sha256_test;
import 'crypto/hash/sha384/sha384_test.dart' as sha384_test;
import 'crypto/hash/sha512/sha512_test.dart' as sha512_test;
import 'crypto/hash/sha512_256/sha512_256_test.dart' as sha512_256_test;
import 'crypto/hash/hmac_sha1/hmac_sha1_test.dart' as hmac_sha1_test;
import 'crypto/hash/hmac_sha224/hmac_sha224_test.dart' as hmac_sha224_test;
import 'crypto/hash/hmac_sha256/hmac_sha256_test.dart' as hmac_sha256_test;
import 'crypto/hash/hmac_sha384/hmac_sha384_test.dart' as hmac_sha384_test;
import 'crypto/hash/hmac_sha512/hmac_sha512_test.dart' as hmac_sha512_test;
import 'crypto/hash/hmac_sha512_256/hmac_sha512_256_test.dart' as hmac_sha512_256_test;
import 'crypto/hash/pbkdf2_hmac_sha1/pbkdf2_hmac_sha1_test.dart' as pbkdf2_hmac_sha1_test;
import 'crypto/hash/pbkdf2_hmac_sha224/pbkdf2_hmac_sha224_test.dart' as pbkdf2_hmac_sha224_test;
import 'crypto/hash/pbkdf2_hmac_sha256/pbkdf2_hmac_sha256_test.dart' as pbkdf2_hmac_sha256_test;
import 'crypto/hash/pbkdf2_hmac_sha384/pbkdf2_hmac_sha384_test.dart' as pbkdf2_hmac_sha384_test;
import 'crypto/hash/pbkdf2_hmac_sha512/pbkdf2_hmac_sha512_test.dart' as pbkdf2_hmac_sha512_test;
import 'crypto/hash/pbkdf2_hmac_sha512_256/pbkdf2_hmac_sha512_256_test.dart' as pbkdf2_hmac_sha512_256_test;
import 'crypto/cipher/aes_ctr/aes_ctr_test.dart' as aes_ctr;
import 'crypto/cipher/aes_ecb/aes_ecb_test.dart' as aes_ecb;
import 'crypto/cipher/aes_cbc/aes_cbc_test.dart' as aes_cbc;
import 'crypto/cipher/aes_ofb/aes_ofb_test.dart' as aes_ofb;
import 'crypto/cipher/aes_cfb/aes_cfb_test.dart' as aes_cfb;
import 'crypto/cipher/chacha/chacha_test.dart' as chacha;


void startTesting([iterations=1]) {
  // Initialize the integration test binding. This is crucial!
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Configure your internal logger for integration tests if needed
  logging_pkg.Logger.root.level = logging_pkg.Level.ALL;
  logging_pkg.Logger.root.onRecord.listen((record) {
    if (record.level != logging_pkg.Level.FINEST && record.level != logging_pkg.Level.FINE) {
      // ignore: avoid_print
      print('[INTEGRATION_LOG] ${record.level.name}: ${record.message}');
    }
  });
  log.configure(showStackTraces: true); // Enable stack traces for integration test logs

  final List<List<GrillGroupFunc>> testList = [
    sha1_test.testGroupList,
    sha224_test.testGroupList,
    sha256_test.testGroupList,
    sha384_test.testGroupList,
    sha512_test.testGroupList,
    sha512_256_test.testGroupList,
    hmac_sha1_test.testGroupList,
    hmac_sha224_test.testGroupList,
    hmac_sha256_test.testGroupList,
    hmac_sha384_test.testGroupList,
    hmac_sha512_test.testGroupList,
    hmac_sha512_256_test.testGroupList,
    pbkdf2_hmac_sha1_test.testGroupList,
    pbkdf2_hmac_sha224_test.testGroupList,
    pbkdf2_hmac_sha256_test.testGroupList,
    pbkdf2_hmac_sha384_test.testGroupList,
    pbkdf2_hmac_sha512_test.testGroupList,
    pbkdf2_hmac_sha512_256_test.testGroupList,
    aes_ctr.testGroupList,
    aes_ecb.testGroupList,
    aes_cbc.testGroupList,
    aes_ofb.testGroupList,
    aes_cfb.testGroupList,
    chacha.testGroupList,
  ];
  final List<List<GrillGroupFunc>> benchmarkList = [
    sha1_test.benchmarkGroupList,
    sha224_test.benchmarkGroupList,
    sha256_test.benchmarkGroupList,
    sha384_test.benchmarkGroupList,
    sha512_test.benchmarkGroupList,
    sha512_256_test.benchmarkGroupList,
    hmac_sha1_test.benchmarkGroupList,
    hmac_sha224_test.benchmarkGroupList,
    hmac_sha256_test.benchmarkGroupList,
    hmac_sha384_test.benchmarkGroupList,
    hmac_sha512_test.benchmarkGroupList,
    hmac_sha512_256_test.benchmarkGroupList,
    pbkdf2_hmac_sha1_test.benchmarkGroupList,
    pbkdf2_hmac_sha224_test.benchmarkGroupList,
    pbkdf2_hmac_sha256_test.benchmarkGroupList,
    pbkdf2_hmac_sha384_test.benchmarkGroupList,
    pbkdf2_hmac_sha512_test.benchmarkGroupList,
    pbkdf2_hmac_sha512_256_test.benchmarkGroupList,
    aes_ctr.benchmarkGroupList,
    aes_ecb.benchmarkGroupList,
    aes_cbc.benchmarkGroupList,
    aes_ofb.benchmarkGroupList,
    aes_cfb.benchmarkGroupList,
    chacha.benchmarkGroupList,
  ];
  

  group('BoringSSL FFI Integration Tests', () {
    for (final testGroupList in testList) {
      for (final testGroup in testGroupList) {
        testGroup(iterations);
      }
    }
    // You would add groups for other modules (AES, RSA, etc.) here as well.
  });

  if (iterations != 1) {
    for (final benchmarkGroupList in benchmarkList) {
      for (final benchmarkGroup in benchmarkGroupList) {
        benchmarkGroup(iterations);
      }
    }
  }
}
