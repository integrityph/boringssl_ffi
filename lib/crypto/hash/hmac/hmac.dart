import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:boringssl_ffi/src/bindings/bindings.dart' as bindings;
import 'package:boringssl_ffi/src/ffi_lib/ffi_lib.dart';
import 'package:boringssl_ffi/src/logging/logging.dart';

const hmac = HMAC();

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

enum _hmacHashTypes {
  sha1(envNID: NID_sha1, length: 20),
  sha224(envNID: NID_sha224, length: 28),
  sha256(envNID: NID_sha256, length: 32),
  sha384(envNID: NID_sha384, length: 48),
  sha512(envNID: NID_sha512, length: 64),
  sha512_256(envNID: NID_sha512_256, length: 32);

  const _hmacHashTypes({
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

class HMAC {
  /*
  The full list:
   - EVP_md4
   - EVP_md5
   - EVP_sha1
   - EVP_sha224
   - EVP_sha256
   - EVP_sha384
   - EVP_sha512
   - EVP_sha512_256
   - EVP_blake2b256
   - EVP_md5_sha1
   note: EVP_md5_sha1 is a TLS-specific EVP_MD which computes the concatenation of MD5 and SHA-1, as used in TLS 1.1 and below.
  */

  const HMAC();

  Uint8List? hmacSHA1(List<int> key, List<int> data) {
    return _hmac(key, data, _hmacHashTypes.sha1);
  }

  Uint8List? hmacSHA224(List<int> key, List<int> data) {
    return _hmac(key, data, _hmacHashTypes.sha224);
  }

  Uint8List? hmacSHA256(List<int> key, List<int> data) {
    return _hmac(key, data, _hmacHashTypes.sha256);
  }

  Uint8List? hmacSHA384(List<int> key, List<int> data) {
    return _hmac(key, data, _hmacHashTypes.sha384);
  }

  Uint8List? hmacSHA512(List<int> key, List<int> data) {
    return _hmac(key, data, _hmacHashTypes.sha512);
  }

  Uint8List? hmacSHA512_256(List<int> key, List<int> data) {
    return _hmac(key, data, _hmacHashTypes.sha512_256);
  }

  Uint8List? _hmac(List<int> key, List<int> data, _hmacHashTypes env) {
    return arenaWrapper((Arena arena) {
      if (env.objectPtr == ffi.nullptr) {
        print("HMAC._hmac: underlying EVP_MD pointer for ${env.name} is NULL.");
        return null;
      }

      final ffi.Pointer<ffi.Uint8> keyPtr = arena.allocate<ffi.Uint8>(
        key.length,
      );
      final ffi.Pointer<ffi.Uint8> dataPtr = arena.allocate<ffi.Uint8>(
        data.length,
      );
      final ffi.Pointer<ffi.Uint8> digestPtr = arena.allocate<ffi.Uint8>(
        env.length,
      );
      final ffi.Pointer<ffi.UnsignedInt> digestLenPtr = arena.allocate<ffi.UnsignedInt>(
        ffi.sizeOf<ffi.UnsignedInt>(),
      );

      keyPtr.asTypedList(key.length).setAll(0, key);
      dataPtr.asTypedList(data.length).setAll(0, data);

      final resultPtr = ffiBindings.HMAC(env.objectPtr!, keyPtr.cast<ffi.Void>(), key.length, dataPtr, data.length, digestPtr, digestLenPtr);

      // Check if the call was successful. A NULL pointer indicates failure.
      if (resultPtr != ffi.nullptr && digestLenPtr != ffi.nullptr) {
        return returnUint8List(digestPtr, digestLenPtr.value);
      } else {
        // This is a rare failure case for the SHA512 function.
        log.log("HMAC._hmac: function call failed for algorithm ${env.name}.");
        return null;
      }
    });
  }
}
