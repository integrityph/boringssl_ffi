part of 'aes_main.dart';

const _aes_cbc = AES_CBC();

class AES_CBC {
  const AES_CBC();

  Uint8List? encrypt(List<int> data, List<int> key, List<int> ivec, {bool enablePadding=false}) {
    return _encrypt(data.toUint8List(), key.toUint8List(), ivec.toUint8List(), AES.AES_ENCRYPT, enablePadding:enablePadding);
  }

  Uint8List? decrypt(List<int> data, List<int> key, List<int> ivec, {bool enablePadding=false}) {
    return _encrypt(data.toUint8List(), key.toUint8List(), ivec.toUint8List(), AES.AES_DECRYPT, enablePadding:enablePadding);
  }

  Uint8List? _encrypt(Uint8List data, Uint8List key, Uint8List ivec, int enc, {bool enablePadding=false}) {
    return arenaWrapper((SafeArena arena) {
      // Use PKCS#7 padding first
      if (enablePadding && enc == AES.AES_ENCRYPT) {
        data = padPKCS7(data, AES.BLOCK_SIZE)!;
      }

      if ((data.length % AES.BLOCK_SIZE) != 0) {
        logger.log("AES_CBC._encrypt: Invalid input size. Either enable padding or ensure the data length is a multiple of 16");
      }

      List<int> output = [];

      // setup the key
      ffi.Pointer<bindings.AES_KEY>? keyPtr;
      if (enc == AES.AES_ENCRYPT) {
        keyPtr = aes._makeEncryptKey(arena, key);
      } else {
        keyPtr = aes._makeDecryptKey(arena, key);
      }
      if (keyPtr == null) {
        logger.log("AES_ECB.encrypt: unable to encrypt, key creation failed");
        return null;
      }

      final ffi.Pointer<ffi.Uint8> inputPtr = arena.allocate<ffi.Uint8>(
        AES.BLOCK_SIZE,
      );
      final ffi.Pointer<ffi.Uint8> outputPtr = arena.allocate<ffi.Uint8>(
        AES.BLOCK_SIZE,
      );
      final ffi.Pointer<ffi.Uint8> ivecPtr = arena.allocate<ffi.Uint8>(
        ivec.length,
      );
      ivecPtr.asTypedList(ivec.length).setAll(0, ivec);

      for (int i = 0; i < data.length; i = i + AES.BLOCK_SIZE) {
        // Copy the input data to the native memory buffer.
        inputPtr
            .asTypedList(AES.BLOCK_SIZE)
            .setAll(0, data.sublist(i, i + AES.BLOCK_SIZE));

        // Call the native function.
        // It returns a pointer to the output buffer on success, or NULL on failure.
        ffiBindings.AES_cbc_encrypt(
          inputPtr,
          outputPtr,
          AES.BLOCK_SIZE,
          keyPtr,
          ivecPtr,
          enc,
        );

        if (outputPtr == ffi.nullptr) {
          logger.log("AES_ECB.encrypt: null output");
          return null;
        }

        output.addAll(returnUint8List(outputPtr, AES.BLOCK_SIZE));
      }

      if (enablePadding && enc == AES.AES_DECRYPT) {
        output = unpadPKCS7(output, AES.BLOCK_SIZE)!;
      }

      return Uint8List.fromList(output);
    });
  }
}
