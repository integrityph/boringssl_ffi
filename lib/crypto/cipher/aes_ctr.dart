part of 'aes.dart';

const _aes_ctr = AES_CTR();

class AES_CTR {
  const AES_CTR();

  ({Uint8List cipher, int num})? encrypt(
    List<int> data,
    List<int> key,
    List<int> ivec,
    List<int> ecountBuf,
    int num,
  ) {
    return _encrypt(data,key,ivec,ecountBuf,num);
  }

  ({Uint8List cipher, int num})? decrypt(
    List<int> data,
    List<int> key,
    List<int> ivec,
    List<int> ecountBuf,
    int num,
  ) {
    return _encrypt(data,key,ivec,ecountBuf,num);
  }

  ({Uint8List cipher, int num})? _encrypt(
    List<int> data,
    List<int> key,
    List<int> ivec,
    List<int> ecountBuf,
    int num,
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
        log.log("AES_CTR128.encrypt: unable to encrypt, key creation failed");
        return null;
      }

      final ffi.Pointer<ffi.Uint8> ivecPtr = arena.allocate<ffi.Uint8>(ivec.length);
      ivecPtr.asTypedList(ivec.length).setAll(0, ivec);

      final ffi.Pointer<ffi.Uint8> ecount_bufPtr = arena.allocate<ffi.Uint8>(ecountBuf.length);
      ecount_bufPtr.asTypedList(ecountBuf.length).setAll(0, ecountBuf);

      final ffi.Pointer<ffi.UnsignedInt> numPtr = arena.allocate<ffi.UnsignedInt>(
        ffi.sizeOf<ffi.UnsignedInt>(),
      );
      numPtr.value = num;

      // Call the native function.
      // It returns a pointer to the output buffer on success, or NULL on failure.
      ffiBindings.AES_ctr128_encrypt(
        inputPtr,
        outputPtr,
        data.length,
        keyPtr,
        ivecPtr,
        ecount_bufPtr,
        numPtr,
      );

      // validate results
      if (outputPtr == ffi.nullptr) {
        log.log("AES_CTR128.encrypt: null output");
        return null;
      }

      // read returned values
      ivec.setAll(0, ivecPtr.asTypedList(ivec.length));
      ecountBuf.setAll(0, ecount_bufPtr.asTypedList(ecountBuf.length));
      num = numPtr.value;

      return (cipher: returnUint8List(outputPtr, data.length), num: num);
    });
  }
}
