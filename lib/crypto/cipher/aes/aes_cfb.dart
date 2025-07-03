part of 'aes_main.dart';

const _aes_cfb = AES_CFB();

class AES_CFB {
  const AES_CFB();

  ({Uint8List cipher, int num})? encrypt(
    List<int> data,
    List<int> key,
    List<int> ivec,
    int num,
  ) {
    return _encrypt(data, key, ivec, num, AES.AES_ENCRYPT);
  }

  ({Uint8List cipher, int num})? decrypt(
    List<int> data,
    List<int> key,
    List<int> ivec,
    int num,
  ) {
    return _encrypt(data, key, ivec, num, AES.AES_DECRYPT);
  }

  ({Uint8List cipher, int num})? _encrypt(
    List<int> data,
    List<int> key,
    List<int> ivec,
    int num,
    int enc
  ) {
    return arenaWrapper((Arena arena) {
      final ffi.Pointer<ffi.Uint8> inputPtr = arena.allocate<ffi.Uint8>(
        data.length,
      );

      // Allocate native memory for the output. since CTR uses XOR, the size of
      // the output is equal to the size of the input
      final ffi.Pointer<ffi.Uint8> outputPtr = arena.allocate<ffi.Uint8>(
        data.length,
      );

      // Copy the input data to the native memory buffer.
      inputPtr.asTypedList(data.length).setAll(0, data);

      // setup the key
      final keyPtr = aes._makeEncryptKey(arena, key);

      if (keyPtr == null) {
        log.log("AES_CFB._decrypt: unable to encrypt, key creation failed");
        return null;
      }

      final ffi.Pointer<ffi.Uint8> ivecPtr = arena.allocate<ffi.Uint8>(ivec.length);
      ivecPtr.asTypedList(ivec.length).setAll(0, ivec);

      final ffi.Pointer<ffi.Int> numPtr = arena.allocate<ffi.Int>(
        ffi.sizeOf<ffi.Int>(),
      );
      numPtr.value = num;

      // Call the native function.
      // It returns a pointer to the output buffer on success, or NULL on failure.
      ffiBindings.AES_cfb128_encrypt(
        inputPtr,
        outputPtr,
        data.length,
        keyPtr,
        ivecPtr,
        numPtr,
        enc,
      );

      // validate results
      if (outputPtr == ffi.nullptr) {
        log.log("AES_CFB._decrypt: null output");
        return null;
      }

      // read returned values
      ivec.setAll(0, ivecPtr.asTypedList(ivec.length));
      num = numPtr.value;

      return (cipher: returnUint8List(outputPtr, data.length), num: num);
    });
  }
}
