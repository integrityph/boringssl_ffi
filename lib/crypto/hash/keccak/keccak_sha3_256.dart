import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:boringssl_ffi/src/bindings/bindings.dart' as bindings;
import 'package:boringssl_ffi/src/ffi_lib/ffi_lib.dart';
import 'package:boringssl_ffi/src/helpers/conversion/list_to_bytearray.dart';

const keccak256 = Keccak256();

class Keccak256 {
  static const int KECCAK_SHA3_256_DIGEST_LENGTH = 32;
  const Keccak256();

  Uint8List? hash(List<int> data) {
    return _hash(data.toUint8List());
  }

  Uint8List? _hash(Uint8List data) {
    return arenaWrapper((SafeArena arena) {
      final dataPtr = data.toFFIPointer(arena);
      final outPtr = arena.allocate<ffi.Uint8>(KECCAK_SHA3_256_DIGEST_LENGTH);
      ffiBindings.BORINGSSL_keccak(
        outPtr,
        KECCAK_SHA3_256_DIGEST_LENGTH,
        dataPtr,
        data.length,
        bindings.boringssl_keccak_config_t.boringssl_sha3_256,
      );
      return returnUint8List(outPtr, KECCAK_SHA3_256_DIGEST_LENGTH);
    });
    
  }
}
