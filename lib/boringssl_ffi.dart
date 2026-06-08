library;

// export 'crypto/crypto.dart';
// export 'src/encoding/encoding.dart';

import 'crypto/crypto.dart' as crypto;
import 'src/encoding/encoding.dart' as encoding;

const bssl = BoringSSLFFI();

class BoringSSLFFI {
  const BoringSSLFFI();

  // Hashes
  final sha1 = crypto.sha1;
  final sha224 = crypto.sha224;
  final sha256 = crypto.sha256;
  final sha384 = crypto.sha384;
  final sha512 = crypto.sha512;
  final sha512_256 = crypto.sha512_256;
  final keccak = crypto.keccak;
  final hmac = crypto.hmac;

  // cipher
  final aead = crypto.aead;
  final aes = crypto.aes;
  final chacha20 = crypto.chacha20;

  // key derivation
  final hkdf = crypto.hkdf;
  final pbkdf2HMAC = crypto.pbkdf2HMAC;
  
  // kem
  final kyber = crypto.kyber;

  // pkcs
  final rsa = crypto.rsa;

  // encoding
  final hex = encoding.hex;
}