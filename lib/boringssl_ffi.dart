// This file is located at boringssl_ffi/lib/boringssl_ffi.dart
import 'dart:ffi' as ffi;
import 'dart:io' show Platform;
import 'dart:typed_data';
import 'package:boringssl_ffi/boringssl_bindings.dart';
import 'package:ffi/ffi.dart';

// --- FFI Signature Definitions ---
// It's good practice to make these private to the library.

// C signature: const char* SSLeay_version(int type);
// typedef _SSLeayVersionNative = Pointer<Utf8> Function(Int32 type);
// // Dart signature
// typedef _SSLeayVersionDart = Pointer<Utf8> Function(int type);

// --- Main Plugin Class ---

/// A class that provides access to the BoringSSL native library.
class BoringSslFFI {
  // The name of the library that our CMakeLists.txt produces.
  static final _libName = 'boringssl_ffi';
	static final ffi.DynamicLibrary _dylib = _openDylib();
	static final BoringSSLBindings _bindings = BoringSSLBindings(_dylib);

	static ffi.DynamicLibrary _openDylib() {
    try {
      if (Platform.isMacOS || Platform.isIOS) {
        // For Apple platforms, the FFI plugin system builds a framework.
        return ffi.DynamicLibrary.open('boringssl_ffi.framework/boringssl_ffi');
        // return DynamicLibrary.open('libboringssl_ffi.dylib');
      }
      if (Platform.isAndroid || Platform.isLinux) {
        // For Linux and Android, it's a standard shared object.
        return ffi.DynamicLibrary.open('lib$_libName.so');
      }
      if (Platform.isWindows) {
        // For Windows, it's a dynamic-link library.
        return ffi.DynamicLibrary.open('$_libName.dll');
      }
    } catch (e) {
      print(e);
      rethrow;
    }

    throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
  }


  BoringSslFFI._();

  

  static String getVersion() {
    final pointer = _bindings.SSLeay_version(0);
    return pointer.cast<Utf8>().toDartString();
  }

	static Uint8List? SHA256(List<int> data) {
		final int sha256DigestLength = 32;
		final arena = Arena();
    try {
      // Allocate native memory for the input data.
      final ffi.Pointer<ffi.Uint8> inputPtr = arena.allocate<ffi.Uint8>(
        data.length,
      );

      // Allocate native memory for the 32-byte output hash.
      final ffi.Pointer<ffi.Uint8> outputPtr = arena.allocate<ffi.Uint8>(
        sha256DigestLength, // Assumes: static const int sha256DigestLength = 32;
      );

      // Copy the input data to the native memory buffer.
      inputPtr.asTypedList(data.length).setAll(0, data);

      // Call the native function.
      // It returns a pointer to the output buffer on success, or NULL on failure.
      final ffi.Pointer<ffi.Uint8> resultPtr = _bindings.SHA256(
        inputPtr,
        data.length,
        outputPtr,
      );

      // Check if the call was successful. A NULL pointer indicates failure.
      if (resultPtr != ffi.nullptr) {
        return _returnUint8List(outputPtr, sha256DigestLength);
      } else {
        // This is a rare failure case for the SHA256 function.
        print("FFI: SHA256 function call failed.");
        return null;
      }
    } finally {
      // Release all memory allocated by the arena in this scope.
      arena.releaseAll();
    }
  }

	static String hex_encode(Iterable<int> data) {
		return data.map((int v)=>v.toRadixString(16).padLeft(2,"0")).join("");
	}

	static Uint8List _returnUint8List(
    ffi.Pointer<ffi.Uint8> pointer,
    int length,
  ) {
    return Uint8List.fromList(pointer.asTypedList(length).toList());
  }
}
