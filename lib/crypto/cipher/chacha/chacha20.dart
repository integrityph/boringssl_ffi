import 'dart:typed_data';
import 'dart:ffi' as ffi;
import 'package:boringssl_ffi/src/ffi_lib/ffi_lib.dart';
import 'package:boringssl_ffi/src/logging/logging.dart';

part 'chacha20_session.dart';

const chacha20 = ChaCha20();

class ChaCha20 {
  static const BLOCK_SIZE = 64;
  const ChaCha20();

  ChaCha20Session initSession(List<int> key, List<int> nonce, int counter) {
    return ChaCha20Session(key, nonce, counter);
  }

  Uint8List? encrypt(
    List<int> data,
    List<int> key,
    List<int> nonce,
    int counter,
  ) {
    return _encrypt(data, key, nonce, counter);
  }

  Uint8List? decrypt(
    List<int> data,
    List<int> key,
    List<int> nonce,
    int counter,
  ) {
    return _encrypt(data, key, nonce, counter);
  }

  Uint8List? _encrypt(
    List<int> data,
    List<int> key,
    List<int> nonce,
    int counter,
  ) {
    return arenaWrapper((Arena arena) {
      // sanity check
      if (key.length != 32) {
        log.log(
          "ChaCha20._encrypt: key size should be 32, but got ${key.length}",
        );
        return null;
      }
      if (nonce.length != 12) {
        log.log(
          "ChaCha20._encrypt: nonce size should be 12, but got ${nonce.length}",
        );
        return null;
      }
      final ffi.Pointer<ffi.Uint8> inputPtr = arena.allocate<ffi.Uint8>(
        data.length,
      );
      inputPtr.asTypedList(data.length).setAll(0, data);

      final ffi.Pointer<ffi.Uint8> keyPtr = arena.allocate<ffi.Uint8>(
        key.length,
      );
      keyPtr.asTypedList(key.length).setAll(0, key);

      final ffi.Pointer<ffi.Uint8> noncePtr = arena.allocate<ffi.Uint8>(
        nonce.length,
      );
      noncePtr.asTypedList(nonce.length).setAll(0, nonce);

      final ffi.Pointer<ffi.Uint8> outputPtr = arena.allocate<ffi.Uint8>(
        data.length,
      );

      ffiBindings.CRYPTO_chacha_20(
        outputPtr,
        inputPtr,
        data.length,
        keyPtr,
        noncePtr,
        counter,
      );

      if (outputPtr == ffi.nullptr) {
        log.log("ChaCha20._encrypt: null output");
        return null;
      }

      return returnUint8List(outputPtr, data.length);
    });
  }
}
