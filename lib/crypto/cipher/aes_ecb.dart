part of 'aes.dart';

const _aes_ecb = AES_ECB();

class AES_ECB {
  static const AES_ENCRYPT = 1;
  static const AES_DECRYPT = 0;
  static const BLOCK_SIZE = 16;
  const AES_ECB();

  Uint8List? encrypt(List<int> data, List<int> key) {
    return _encrypt(data,key, AES_ENCRYPT);
  }

  Uint8List? decrypt(List<int> data, List<int> key) {
    return _encrypt(data,key, AES_DECRYPT);
  }

  Uint8List? _encrypt(List<int> data, List<int> key, int enc) {
    return arenaWrapper((Arena arena) {
      // Use PKCS#7 padding first
      if (enc == AES_ENCRYPT) {
        data = padPKCS7(data, BLOCK_SIZE)!;
      }

      List<int> output = [];

      // setup the key
      ffi.Pointer<bindings.AES_KEY>? keyPtr;
      if (enc == AES_ENCRYPT) {
        keyPtr = aes._makeEncryptKey(arena, key);
      } else {
        keyPtr = aes._makeDecryptKey(arena, key);
      }
      if (keyPtr == null) {
        log.log("AES_ECB.encrypt: unable to encrypt, key creation failed");
        return null;
      }

      final ffi.Pointer<ffi.Uint8> inputPtr = arena.allocate<ffi.Uint8>(
        BLOCK_SIZE,
      );
      final ffi.Pointer<ffi.Uint8> outputPtr = arena.allocate<ffi.Uint8>(
        BLOCK_SIZE,
      );

      for (int i = 0; i < data.length; i = i + BLOCK_SIZE) {
        // Copy the input data to the native memory buffer.
        inputPtr
            .asTypedList(BLOCK_SIZE)
            .setAll(0, data.sublist(i, i + BLOCK_SIZE));

        // Call the native function.
        // It returns a pointer to the output buffer on success, or NULL on failure.
        ffiBindings.AES_ecb_encrypt(inputPtr, outputPtr, keyPtr, enc);

        if (outputPtr == ffi.nullptr) {
          log.log("AES_ECB.encrypt: null output");
          return null;
        }

        output.addAll(returnUint8List(outputPtr, BLOCK_SIZE));
      }

      if (enc == AES_DECRYPT) {
        output = unpadPKCS7(output, BLOCK_SIZE)!;
      }

      return Uint8List.fromList(output);
    });
  }
}
