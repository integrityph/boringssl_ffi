// This file is located at boringssl_ffi/lib/boringssl_ffi.dart
import 'dart:ffi';
import 'dart:io' show Platform;
import 'package:ffi/ffi.dart';

// --- FFI Signature Definitions ---
// It's good practice to make these private to the library.

// C signature: const char* SSLeay_version(int type);
typedef _SSLeayVersionNative = Pointer<Utf8> Function(Int32 type);
// Dart signature
typedef _SSLeayVersionDart = Pointer<Utf8> Function(int type);

// --- Main Plugin Class ---

/// A class that provides access to the BoringSSL native library.
class BoringSslFFI {
  // The name of the library that our CMakeLists.txt produces.
  static const _libName = 'boringssl_ffi';

  /// A handle to the looked-up C function.
  late final _SSLeayVersionDart _ssleayVersion;

  /// Creates an instance of the FFI bindings.
  ///
  /// This loads the dynamic library and looks up the functions right away.
  BoringSslFFI() {
    final dylib = _openDylib();

    // Look up the function 'SSLeay_version' by its exact C name.
    _ssleayVersion = dylib
        .lookup<NativeFunction<_SSLeayVersionNative>>('SSLeay_version')
        .asFunction<_SSLeayVersionDart>();
  }

  DynamicLibrary _openDylib() {
    try {
      if (Platform.isMacOS || Platform.isIOS) {
        // For Apple platforms, the FFI plugin system builds a framework.
        return DynamicLibrary.open('boringssl_ffi.framework/boringssl_ffi');
        // return DynamicLibrary.open('libboringssl_ffi.dylib');
      }
      if (Platform.isAndroid || Platform.isLinux) {
        // For Linux and Android, it's a standard shared object.
        return DynamicLibrary.open('lib$_libName.so');
      }
      if (Platform.isWindows) {
        // For Windows, it's a dynamic-link library.
        return DynamicLibrary.open('$_libName.dll');
      }
    } catch (e) {
      print(e);
      rethrow;
    }

    throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
  }

  /// A simple "hello world" function to get the BoringSSL version string.
  /// This proves that the FFI connection is working.
  String getVersion() {
    // Call the C function. The constant 0 corresponds to SSLEAY_VERSION.
    final pointer = _ssleayVersion(0);
    // ffi.dart provides a convenient extension method to convert a
    // C string pointer to a Dart String.
    return pointer.toDartString();
  }

  // --- Next Steps ---
  // You will add more functions here, binding directly to BoringSSL's API.
  // For example, to create an SSL_CTX:
  //
  // C signature: SSL_CTX *SSL_CTX_new(const SSL_METHOD *method);
  //
  // You would add:
  // 1. A typedef for the opaque SSL_CTX and SSL_METHOD structs:
  //    class SSL_CTX extends Opaque {}
  //    class SSL_METHOD extends Opaque {}
  //
  // 2. The FFI signature definitions:
  //    typedef _SslCtxNewNative = Pointer<SSL_CTX> Function(Pointer<SSL_METHOD> method);
  //    typedef _SslCtxNewDart = Pointer<SSL_CTX> Function(Pointer<SSL_METHOD> method);
  //
  // 3. The function lookup in the constructor:
  //    _sslCtxNew = dylib.lookup<...>(...).asFunction<...>();
  //
  // 4. A clean public Dart method:
  //    Pointer<SSL_CTX> sslCtxNew(Pointer<SSL_METHOD> method) => _sslCtxNew(method);
}
