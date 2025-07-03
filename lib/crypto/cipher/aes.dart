import 'dart:typed_data';
import 'dart:ffi' as ffi;
import 'package:boringssl_ffi/src/bindings/bindings.dart' as bindings;
import 'package:boringssl_ffi/src/ffi_lib/ffi_lib.dart';
import 'package:boringssl_ffi/src/helpers/pkcs7.dart';
import 'package:boringssl_ffi/src/logging/logging.dart';

part 'aes_ecb.dart';
part 'aes_ctr.dart';
part 'aes_cbc.dart';
part 'aes_ofb.dart';
part 'aes_cfb.dart';

const aes = AES();

class AES {
  const AES();

  AES_CTR get ctr {
    return _aes_ctr;
  }

  AES_ECB get ecb {
    return _aes_ecb;
  }

  AES_CBC get cbc {
    return _aes_cbc;
  }

  AES_OFB get ofb {
    return _aes_ofb;
  }

  AES_CFB get cfb {
    return _aes_cfb;
  }

  ffi.Pointer<bindings.AES_KEY>? _makeEncryptKey(Arena arena, List<int> key) {
    if (key.length != 16 && key.length != 24 && key.length != 32) {
      log.log(
        "Invalid AES key size. Valid key sizes are 16, 24 or 32 but found ${key.length}",
      );
      return null;
    }

    final ffi.Pointer<ffi.Uint8> keyPtr = arena.allocate<ffi.Uint8>(key.length);
    keyPtr.asTypedList(key.length).setAll(0, key);

    final ffi.Pointer<bindings.AES_KEY> aesKeyPtr = arena
        .allocate<bindings.AES_KEY>(ffi.sizeOf<bindings.AES_KEY>());

    final keySetResult = ffiBindings.AES_set_encrypt_key(
      keyPtr,
      key.length * 8,
      aesKeyPtr,
    );

    if (keySetResult != 0) {
      log.log("AES_set_encrypt_key failed with code: $keySetResult");
      return null;
    }

    return aesKeyPtr;
  }

  ffi.Pointer<bindings.AES_KEY>? _makeDecryptKey(Arena arena, List<int> key) {
    if (key.length != 16 && key.length != 24 && key.length != 32) {
      log.log(
        "Invalid AES key size. Valid key sizes are 16, 24 or 32 but found ${key.length}",
      );
      return null;
    }

    final ffi.Pointer<ffi.Uint8> keyPtr = arena.allocate<ffi.Uint8>(key.length);
    keyPtr.asTypedList(key.length).setAll(0, key);

    final ffi.Pointer<bindings.AES_KEY> aesKeyPtr = arena
        .allocate<bindings.AES_KEY>(ffi.sizeOf<bindings.AES_KEY>());

    final keySetResult = ffiBindings.AES_set_decrypt_key(
      keyPtr,
      key.length * 8,
      aesKeyPtr,
    );

    if (keySetResult != 0) {
      log.log("AES_set_decrypt_key failed with code: $keySetResult");
      return null;
    }

    return aesKeyPtr;
  }
}

