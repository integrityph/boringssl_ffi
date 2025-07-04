import 'dart:ffi' as ffi;
import 'dart:typed_data';
import 'package:boringssl_ffi/src/ffi_lib/ffi_lib.dart';
import 'package:boringssl_ffi/src/logging/logging.dart';

const sha256 = Sha256();

class Sha256 {
  final int SHA256_DIGEST_LENGTH = 32;

  const Sha256();

  Uint8List? hash(List<int> data) {		
    return arenaWrapper((Arena arena) {
      final ffi.Pointer<ffi.Uint8> inputPtr = arena.allocate<ffi.Uint8>(
        data.length,
      );

      // Allocate native memory for the 32-byte output hash.
      final ffi.Pointer<ffi.Uint8> outputPtr = arena.allocate<ffi.Uint8>(
        SHA256_DIGEST_LENGTH,
      );

      // Copy the input data to the native memory buffer.
      inputPtr.asTypedList(data.length).setAll(0, data);

      // Call the native function.
      // It returns a pointer to the output buffer on success, or NULL on failure.
      final ffi.Pointer<ffi.Uint8> resultPtr = ffiBindings.SHA256(
        inputPtr,
        data.length,
        outputPtr,
      );

      // Check if the call was successful. A NULL pointer indicates failure.
      if (resultPtr != ffi.nullptr) {
        return returnUint8List(outputPtr, SHA256_DIGEST_LENGTH);
      } else {
        // This is a rare failure case for the SHA256 function.
        logger.log("SHA256 function call failed");
        return null;
      }
    });
  }
}