import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:boringssl_ffi/src/logging/logging.dart';
import 'package:boringssl_ffi/src/bindings/bindings.dart';

final ffiBindings = _FFIBindings().bindings;

class _FFIBindings {
  static final _libName = 'boringssl_ffi';
  final BoringSSLBindings bindings;

  _FFIBindings() : bindings = _getBindings();

  static BoringSSLBindings _getBindings() {
    return BoringSSLBindings(_openDylib());
  }

  static ffi.DynamicLibrary _openDylib() {
    try {
      if (Platform.isMacOS || Platform.isIOS) {
        // For Apple platforms, the FFI plugin system builds a framework.
        return ffi.DynamicLibrary.open('$_libName.framework/$_libName');
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
      logger.log("_openDylib failed to open boringSSL binary. $e");
      rethrow;
    }
    throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
  }
}