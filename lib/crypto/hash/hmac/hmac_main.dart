import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:boringssl_ffi/src/helpers/evp/md_evp.dart';
import 'package:boringssl_ffi/src/ffi_lib/ffi_lib.dart';
import 'package:boringssl_ffi/src/logging/logging.dart';

const hmac = HMAC();

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
    return _hmac(key, data, HashAlgorithm.sha1);
  }

  Uint8List? hmacSHA224(List<int> key, List<int> data) {
    return _hmac(key, data, HashAlgorithm.sha224);
  }

  Uint8List? hmacSHA256(List<int> key, List<int> data) {
    return _hmac(key, data, HashAlgorithm.sha256);
  }

  Uint8List? hmacSHA384(List<int> key, List<int> data) {
    return _hmac(key, data, HashAlgorithm.sha384);
  }

  Uint8List? hmacSHA512(List<int> key, List<int> data) {
    return _hmac(key, data, HashAlgorithm.sha512);
  }

  Uint8List? hmacSHA512_256(List<int> key, List<int> data) {
    return _hmac(key, data, HashAlgorithm.sha512_256);
  }

  Uint8List? _hmac(List<int> key, List<int> data, HashAlgorithm hashAlgorithm) {
    return arenaWrapper((Arena arena) {
      if (hashAlgorithm.objectPtr == ffi.nullptr) {
        logger.log("HMAC._hmac: underlying EVP_MD pointer for ${hashAlgorithm.name} is NULL.");
        return null;
      }

      final ffi.Pointer<ffi.Uint8> keyPtr = arena.allocate<ffi.Uint8>(
        key.length,
      );
      final ffi.Pointer<ffi.Uint8> dataPtr = arena.allocate<ffi.Uint8>(
        data.length,
      );
      final ffi.Pointer<ffi.Uint8> digestPtr = arena.allocate<ffi.Uint8>(
        hashAlgorithm.length,
      );
      final ffi.Pointer<ffi.UnsignedInt> digestLenPtr = arena.allocate<ffi.UnsignedInt>(
        ffi.sizeOf<ffi.UnsignedInt>(),
      );

      keyPtr.asTypedList(key.length).setAll(0, key);
      dataPtr.asTypedList(data.length).setAll(0, data);

      final resultPtr = ffiBindings.HMAC(hashAlgorithm.objectPtr, keyPtr.cast<ffi.Void>(), key.length, dataPtr, data.length, digestPtr, digestLenPtr);

      // Check if the call was successful. A NULL pointer indicates failure.
      if (resultPtr != ffi.nullptr && digestLenPtr != ffi.nullptr) {
        return returnUint8List(digestPtr, digestLenPtr.value);
      } else {
        // This is a rare failure case for the SHA512 function.
        logger.log("HMAC._hmac: function call failed for algorithm ${hashAlgorithm.name}.");
        return null;
      }
    });
  }
}
