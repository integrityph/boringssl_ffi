import 'dart:ffi' as ffi;
import 'dart:typed_data';
import 'package:boringssl_ffi/src/ffi_lib/ffi_lib.dart';

extension Uint8ListAllocator on Uint8List {
  ffi.Pointer<ffi.Uint8> toFFIPointer(SafeArena arena) {
    final ptr = arena.allocate<ffi.Uint8>(length);
    ptr.asTypedList(length).setAll(0, this);
    return ptr;
  }
}

extension IntAllocator on int {
  ffi.Pointer<ffi.Int8> toInt8Pointer(SafeArena arena) {
    final ptr = arena.allocate<ffi.Int8>(ffi.sizeOf<ffi.Int8>());
    ptr.value = this;
    return ptr;
  }

  ffi.Pointer<ffi.Uint8> toUint8Pointer(SafeArena arena) {
    final ptr = arena.allocate<ffi.Uint8>(ffi.sizeOf<ffi.Uint8>());
    ptr.value = this;
    return ptr;
  }

  ffi.Pointer<ffi.Int16> toInt16Pointer(SafeArena arena) {
    final ptr = arena.allocate<ffi.Int16>(ffi.sizeOf<ffi.Int16>());
    ptr.value = this;
    return ptr;
  }

  ffi.Pointer<ffi.Uint16> toUint16Pointer(SafeArena arena) {
    final ptr = arena.allocate<ffi.Uint16>(ffi.sizeOf<ffi.Uint16>());
    ptr.value = this;
    return ptr;
  }

  ffi.Pointer<ffi.Int32> toInt32Pointer(SafeArena arena) {
    final ptr = arena.allocate<ffi.Int32>(ffi.sizeOf<ffi.Int32>());
    ptr.value = this;
    return ptr;
  }

  ffi.Pointer<ffi.Uint32> toUint32Pointer(SafeArena arena) {
    final ptr = arena.allocate<ffi.Uint32>(ffi.sizeOf<ffi.Uint32>());
    ptr.value = this;
    return ptr;
  }

  ffi.Pointer<ffi.Int64> toInt64Pointer(SafeArena arena) {
    final ptr = arena.allocate<ffi.Int64>(ffi.sizeOf<ffi.Int64>());
    ptr.value = this;
    return ptr;
  }

  ffi.Pointer<ffi.Uint64> toUint64Pointer(SafeArena arena) {
    final ptr = arena.allocate<ffi.Uint64>(ffi.sizeOf<ffi.Uint64>());
    ptr.value = this;
    return ptr;
  }

  ffi.Pointer<ffi.Size> toSizePointer(SafeArena arena) {
    final ptr = arena.allocate<ffi.Size>(ffi.sizeOf<ffi.Size>());
    ptr.value = this;
    return ptr;
  }
}