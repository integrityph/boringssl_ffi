import 'dart:ffi' as ffi;
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'package:boringssl_ffi/src/logging/logging.dart';

export 'package:ffi/ffi.dart';

dynamic arenaWrapper(Function(Arena arena) fun) {
  final arena = Arena();
  try {
    return fun(arena);
  } catch (e) {
    logger.log("_arenaWrapper: function call failed. $e");
    return null;
  } finally {
    arena.releaseAll();
  }
}

Uint8List returnUint8List(ffi.Pointer<ffi.Uint8> pointer, int length) {
  return Uint8List.fromList(List<int>.from(pointer.asTypedList(length)));
}
