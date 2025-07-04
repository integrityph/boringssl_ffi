import 'dart:ffi' as ffi;

import 'package:boringssl_ffi/src/bindings/bindings.dart' as bindings;
import 'package:boringssl_ffi/src/ffi_lib/ffi_bindings.dart';

const NID_md4 = 257;
const NID_md5 = 4;
const NID_sha1 = 64;
const NID_sha224 = 675;
const NID_sha256 = 672;
const NID_sha384 = 673;
const NID_sha512 = 674;
const NID_sha512_256 = 962;
const NID_md5_sha1 = 114;
const NID_blake2b256_CUSTOM = -1;

enum HashAlgorithm {
  sha1(envNID: NID_sha1, length: 20),
  sha224(envNID: NID_sha224, length: 28),
  sha256(envNID: NID_sha256, length: 32),
  sha384(envNID: NID_sha384, length: 48),
  sha512(envNID: NID_sha512, length: 64),
  sha512_256(envNID: NID_sha512_256, length: 32);

  const HashAlgorithm({
    required this.envNID,
    required this.length,
  });

  final int envNID;
  final int length;
  static Map<int, ffi.Pointer<bindings.EVP_MD>?> _envCache = {};

  ffi.Pointer<bindings.EVP_MD>? get objectPtr {
    return _envCache.putIfAbsent(envNID, ()=>ffiBindings.EVP_get_digestbynid(envNID));
  }
}