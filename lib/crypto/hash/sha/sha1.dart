import 'dart:ffi' as ffi;
import 'dart:typed_data';
import 'package:boringssl_ffi/src/ffi_lib/ffi_lib.dart';
import 'package:boringssl_ffi/src/logging/logging.dart';

const sha1 = Sha1();

class Sha1 {
  final int SHA1_DIGEST_LENGTH = 20;

  const Sha1();

  /// `hash` performs a one-shot hash function and returns the hash bytes
  ///
  /// Parameters:
  /// [data]: The data to be hashed.
  ///
  /// Returns: The hash, or `null` on failure.
  Uint8List? hash(List<int> data) {
    return arenaWrapper((SafeArena arena) {
      final ffi.Pointer<ffi.Uint8> inputPtr = arena.allocate<ffi.Uint8>(
        data.length,
      );

      // Allocate native memory for the 20-byte output hash.
      final ffi.Pointer<ffi.Uint8> outputPtr = arena.allocate<ffi.Uint8>(
        SHA1_DIGEST_LENGTH,
      );

      // Copy the input data to the native memory buffer.
      inputPtr.asTypedList(data.length).setAll(0, data);

      // Call the native function.
      // It returns a pointer to the output buffer on success, or NULL on failure.
      final ffi.Pointer<ffi.Uint8> resultPtr = ffiBindings.SHA1(
        inputPtr,
        data.length,
        outputPtr,
      );

      // Check if the call was successful. A NULL pointer indicates failure.
      if (resultPtr != ffi.nullptr) {
        return returnUint8List(outputPtr, SHA1_DIGEST_LENGTH);
      } else {
        // This is a rare failure case for the SHA1 function.
        logger.log("SHA1 function call failed");
        return null;
      }
    });
  }
}
