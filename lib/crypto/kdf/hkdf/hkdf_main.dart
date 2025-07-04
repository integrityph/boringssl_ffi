import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:boringssl_ffi/src/ffi_lib/ffi_lib.dart';
import 'package:boringssl_ffi/src/helpers/conversion/list_to_bytearray.dart';
import 'package:boringssl_ffi/src/helpers/evp/md_evp.dart';
import 'package:boringssl_ffi/src/logging/logging.dart';

const hkdf = HKDF();

class HKDF {
  const HKDF();

  @Deprecated("SHA1 is unsecure. Use SHA256 or higher")
  Uint8List? deriveKeySHA1OneShot(
    List<int> secret,
    List<int> salt,
    List<int> info,
    int keyLength,
  ) {
    return _deriveKeyOneShot(
      secret.toUint8List(),
      salt.toUint8List(),
      info.toUint8List(),
      keyLength,
      HashAlgorithm.sha1,
    );
  }

  Uint8List? deriveKeySHA224OneShot(
    List<int> secret,
    List<int> salt,
    List<int> info,
    int keyLength,
  ) {
    return _deriveKeyOneShot(
      secret.toUint8List(),
      salt.toUint8List(),
      info.toUint8List(),
      keyLength,
      HashAlgorithm.sha224,
    );
  }

  Uint8List? deriveKeySHA256OneShot(
    List<int> secret,
    List<int> salt,
    List<int> info,
    int keyLength,
  ) {
    return _deriveKeyOneShot(
      secret.toUint8List(),
      salt.toUint8List(),
      info.toUint8List(),
      keyLength,
      HashAlgorithm.sha256,
    );
  }

  Uint8List? deriveKeySHA384OneShot(
    List<int> secret,
    List<int> salt,
    List<int> info,
    int keyLength,
  ) {
    return _deriveKeyOneShot(
      secret.toUint8List(),
      salt.toUint8List(),
      info.toUint8List(),
      keyLength,
      HashAlgorithm.sha384,
    );
  }

  Uint8List? deriveKeySHA512OneShot(
    List<int> secret,
    List<int> salt,
    List<int> info,
    int keyLength,
  ) {
    return _deriveKeyOneShot(
      secret.toUint8List(),
      salt.toUint8List(),
      info.toUint8List(),
      keyLength,
      HashAlgorithm.sha512,
    );
  }

  Uint8List? deriveKeySHA512_256OneShot(
    List<int> secret,
    List<int> salt,
    List<int> info,
    int keyLength,
  ) {
    return _deriveKeyOneShot(
      secret.toUint8List(),
      salt.toUint8List(),
      info.toUint8List(),
      keyLength,
      HashAlgorithm.sha512_256,
    );
  }

  Uint8List? _deriveKeyOneShot(
    Uint8List secret,
    Uint8List salt,
    Uint8List info,
    int keyLength,
    HashAlgorithm hashAlgorithm,
  ) {
    return arenaWrapper((Arena arena) {
      // check if the envelope object is available
      if (hashAlgorithm.objectPtr == ffi.nullptr) {
        logger.log(
          "HKDF._deriveKey: underlying EVP_MD pointer for ${hashAlgorithm.name} is NULL.",
        );
        return null;
      }
      final secretPtr = secret.toFFIPointer(arena);
      final saltPtr = salt.toFFIPointer(arena);
      final infoPtr = info.toFFIPointer(arena);
      final outPtr = arena.allocate<ffi.Uint8>(keyLength);

      // It returns 1 on success and 0 on failure.
      final int result = ffiBindings.HKDF(
        outPtr,
        keyLength,
        hashAlgorithm.objectPtr,
        secretPtr,
        secret.length,
        saltPtr,
        salt.length,
        infoPtr,
        info.length,
      );

      if (result == 1) {
        return returnUint8List(outPtr, keyLength);
      } else {
        logger.log(
          "HKDF._deriveKeyOneShot: function call failed and returned 0",
        );
        return null;
      }
    });
  }
}
