import 'dart:ffi' as ffi;
import 'dart:typed_data';
import 'package:boringssl_ffi/src/bindings/bindings.dart' as bindings;
import 'package:boringssl_ffi/src/ffi_lib/ffi_lib.dart';
import 'package:boringssl_ffi/src/helpers/conversion/list_to_bytearray.dart';
import 'package:boringssl_ffi/src/logging/logging.dart';
import 'package:flutter/foundation.dart';

class KyberSession {
  late final ffi.Pointer<bindings.KYBER_private_key> _privateKeyPtr;
  late final ffi.Pointer<ffi.Uint8> _publicKeyPtr;
  final _arena = SafeArena();
  KyberSession._();

  static KyberSession? init() {
    KyberSession instance = KyberSession._();
    final result = instance._generateKey();
    if (result == null) {
      logger.log("KyberSession.init: Unable to initialize session");
      return null;
    }
    return instance;
  }

  /// # DANGER - DO NOT USE
  /// This function is not safe and unstable. This is here only for unit testing the library
  /// use `init` instead which is stable.
  @protected
  static initExternalEntropy(List<int> entropy) {
    KyberSession instance = KyberSession._();
    final result = instance._generateKeyFromExternalEntropy(entropy.toUint8List());
    if (result == null) {
      logger.log("KyberSession.initExternalEntropy: Unable to initialize session");
      return null;
    }
    return instance;
  }

  bool? _generateKey() {
    _publicKeyPtr = _arena.allocate<ffi.Uint8>(
      bindings.KYBER_PUBLIC_KEY_BYTES,
      isSensitive: false,
    );
    _privateKeyPtr = _arena.allocate<bindings.KYBER_private_key>(
      ffi.sizeOf<bindings.KYBER_private_key>(),
    );

    _finalizer.attach(_arena, this, detach: _arena);

    ffiBindings.KYBER_generate_key(_publicKeyPtr, _privateKeyPtr);
    if (_privateKeyPtr == ffi.nullptr || _publicKeyPtr == ffi.nullptr) {
      return null;
    }
    return true;
  }

  bool? _generateKeyFromExternalEntropy(Uint8List entropy) {
    _publicKeyPtr = _arena.allocate<ffi.Uint8>(
      bindings.KYBER_PUBLIC_KEY_BYTES,
      isSensitive: false,
    );
    _privateKeyPtr = _arena.allocate<bindings.KYBER_private_key>(
      ffi.sizeOf<bindings.KYBER_private_key>(),
    );

    _finalizer.attach(_arena, this, detach: _arena);

    final entropyPtr = entropy.toFFIPointer(_arena);

    ffiBindings.KYBER_generate_key_external_entropy(_publicKeyPtr, _privateKeyPtr, entropyPtr);
    if (_privateKeyPtr == ffi.nullptr || _publicKeyPtr == ffi.nullptr) {
      return null;
    }
    return true;
  }

  Uint8List? decapsulate(List<int> cipher) {
    final result = _decapsulate(cipher.toUint8List());
    if (result != null) {
      destroy();
    }
    return result;
  }

  Uint8List? decapsulateAndKeepSession(List<int> cipher) {
    return _decapsulate(cipher.toUint8List());
  }

  Uint8List? _decapsulate(Uint8List cipher) {
    return arenaWrapper((SafeArena arena) {
      final cipherPtr = cipher.toFFIPointer(arena);
      final sharedSecretPtr = arena.allocate<ffi.Uint8>(
        bindings.KYBER_SHARED_SECRET_BYTES,
      );
      ffiBindings.KYBER_decap(sharedSecretPtr, cipherPtr, _privateKeyPtr);
      if (sharedSecretPtr == ffi.nullptr) {
        logger.log("KyberSession._decapsulate: failed to decapsulate cipher");
        return null;
      }
      return returnUint8List(
        sharedSecretPtr,
        bindings.KYBER_SHARED_SECRET_BYTES,
      );
    });
  }

  Uint8List? get publicKey  {
    if (_publicKeyPtr == ffi.nullptr) {
      return null;
    }
    return returnUint8List(_publicKeyPtr, bindings.KYBER_PUBLIC_KEY_BYTES);
  }

  void destroy() {
    _arena.releaseAll();
    _finalizer.detach(_arena);
  }

  static final Finalizer<KyberSession> _finalizer = Finalizer(
    (instance) => instance.destroy(),
  );
}
