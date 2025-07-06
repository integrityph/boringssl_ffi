import 'dart:ffi' as ffi;
import 'dart:typed_data';
import 'package:boringssl_ffi/src/ffi_lib/ffi_lib.dart';
import 'package:boringssl_ffi/src/helpers/conversion/list_to_bytearray.dart';
import 'package:boringssl_ffi/src/helpers/evp/md_evp.dart';
import 'package:boringssl_ffi/src/logging/logging.dart';

const pbkdf2HMAC = PBKDF2_HMAC();

class PBKDF2_HMAC {
  const PBKDF2_HMAC();

  @Deprecated("SHA1 is unsecure. Use SHA256 or higher")
  Uint8List? deriveKeySHA1(
    List<int> password,
    List<int> salt,
    int iterations,
    int keyLength,
  ) {
    return _deriveKey(
      password.toUint8List(),
      salt.toUint8List(),
      iterations,
      keyLength,
      HashAlgorithm.sha1,
    );
  }

  Uint8List? deriveKeySHA224(
    List<int> password,
    List<int> salt,
    int iterations,
    int keyLength,
  ) {
    return _deriveKey(
      password.toUint8List(),
      salt.toUint8List(),
      iterations,
      keyLength,
      HashAlgorithm.sha224,
    );
  }

  Uint8List? deriveKeySHA256(
    List<int> password,
    List<int> salt,
    int iterations,
    int keyLength,
  ) {
    return _deriveKey(
      password.toUint8List(),
      salt.toUint8List(),
      iterations,
      keyLength,
      HashAlgorithm.sha256,
    );
  }

  Uint8List? deriveKeySHA384(
    List<int> password,
    List<int> salt,
    int iterations,
    int keyLength,
  ) {
    return _deriveKey(
      password.toUint8List(),
      salt.toUint8List(),
      iterations,
      keyLength,
      HashAlgorithm.sha384,
    );
  }

  Uint8List? deriveKeySHA512(
    List<int> password,
    List<int> salt,
    int iterations,
    int keyLength,
  ) {
    return _deriveKey(
      password.toUint8List(),
      salt.toUint8List(),
      iterations,
      keyLength,
      HashAlgorithm.sha512,
    );
  }

  Uint8List? deriveKeySHA512_256(
    List<int> password,
    List<int> salt,
    int iterations,
    int keyLength,
  ) {
    return _deriveKey(
      password.toUint8List(),
      salt.toUint8List(),
      iterations,
      keyLength,
      HashAlgorithm.sha512_256,
    );
  }

  Uint8List? _deriveKey(
    Uint8List password,
    Uint8List salt,
    int iterations,
    int keyLength,
    HashAlgorithm hashAlgorithm,
  ) {
    return arenaWrapper((SafeArena arena) {
      // check if the envelope object is available
      if (hashAlgorithm.objectPtr == ffi.nullptr) {
        logger.log("PBKDF2_HMAC._deriveKey: underlying EVP_MD pointer for ${hashAlgorithm.name} is NULL.");
        return null;
      }

      final ffi.Pointer<ffi.Uint8> passwordPtr = arena.allocate<ffi.Uint8>(
        password.length,
      );
      passwordPtr.asTypedList(password.length).setAll(0, password);

      final ffi.Pointer<ffi.Uint8> saltPtr = arena.allocate<ffi.Uint8>(
        salt.length,
      );
      saltPtr.asTypedList(salt.length).setAll(0, salt);

      // The output buffer for the derived key.
      final ffi.Pointer<ffi.Uint8> outPtr = arena.allocate<ffi.Uint8>(
        keyLength,
      );

      // It returns 1 on success and 0 on failure.
      final int result = ffiBindings.PKCS5_PBKDF2_HMAC(
        passwordPtr.cast<ffi.Char>(),
        password.length,
        saltPtr,
        salt.length,
        iterations,
        hashAlgorithm.objectPtr,
        keyLength,
        outPtr,
      );

      // heck if the call was successful.
      if (result == 1) {
        return returnUint8List(outPtr, keyLength);
      } else {
        logger.log("PBKDF2_HMAC._deriveKey: PKCS5_PBKDF2_HMAC function call failed and returned 0");
        return null;
      }
    });
  }
}
