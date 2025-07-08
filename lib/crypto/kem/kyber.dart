import 'dart:ffi' as ffi;
import 'dart:typed_data';
import 'package:boringssl_ffi/crypto/hash/keccak/keccak_main.dart';
import 'package:boringssl_ffi/src/bindings/bindings.dart' as bindings;
import 'package:boringssl_ffi/src/ffi_lib/ffi_lib.dart';
import 'package:boringssl_ffi/src/helpers/conversion/list_to_bytearray.dart';
import 'package:boringssl_ffi/src/logging/logging.dart';
import 'package:flutter/foundation.dart';
import 'kyber_session.dart';

const kyber = Kyber();

class Kyber {
  const Kyber();

  KyberSession? initSession() {
    return KyberSession.init();
  }

  /// # DANGER - DO NOT USE
  /// This function is not safe and unstable. This is here only for unit testing the library
  /// use `initSession` instead which is stable.
  @protected
  KyberSession? initSessionExternalEntropy(List<int> entropy) {
    // ignore: invalid_use_of_protected_member
    return KyberSession.initExternalEntropy(entropy);
  }

  ({Uint8List cipher, Uint8List sharedSecret})? encapsulate(
    List<int> remotePublicKey,
  ) {
    return _encapsulate(remotePublicKey.toUint8List());
  }

  /// # DANGER - DO NOT USE
  /// This function is not safe and unstable. This is here only for unit testing the library
  /// use `encapsulate` instead which is stable.
  @protected
  ({Uint8List cipher, Uint8List sharedSecret})? encapsulateExternalEntropy(
    List<int> remotePublicKey,
    List<int> entropy,
  ) {
    return _encapsulateExternalEntropy(remotePublicKey.toUint8List(), entropy.toUint8List());
  }

  ({Uint8List cipher, Uint8List sharedSecret})? _encapsulate(
    Uint8List remotePublicKey,
  ) {
    return arenaWrapper((SafeArena arena) {
      final ffi.Pointer<bindings.CBS> cbsPtr = arena.allocate<bindings.CBS>(
        ffi.sizeOf<bindings.CBS>(),
      );
      cbsPtr.ref.data = remotePublicKey.toFFIPointer(arena);
      cbsPtr.ref.len = remotePublicKey.length;
      final publicKeyPtr = arena.allocate<bindings.KYBER_public_key>(
        bindings.KYBER_PUBLIC_KEY_BYTES,
      );
      final result = ffiBindings.KYBER_parse_public_key(publicKeyPtr, cbsPtr);

      if (result == 0) {
        logger.log("KyberSession._encapsulate: failed to parse public key");
        return null;
      }

      final cipherPtr = arena.allocate<ffi.Uint8>(
        bindings.KYBER_CIPHERTEXT_BYTES,
      );
      final sharedSecretPtr = arena.allocate<ffi.Uint8>(
        bindings.KYBER_SHARED_SECRET_BYTES,
      );
      ffiBindings.KYBER_encap(cipherPtr, sharedSecretPtr, publicKeyPtr);

      return (
        cipher: returnUint8List(cipherPtr, bindings.KYBER_CIPHERTEXT_BYTES),
        sharedSecret: returnUint8List(
          sharedSecretPtr,
          bindings.KYBER_SHARED_SECRET_BYTES,
        ),
      );
    });
  }

  ({Uint8List cipher, Uint8List sharedSecret})? _encapsulateExternalEntropy(
    Uint8List remotePublicKey,
    Uint8List entropy,
  ) {
    return arenaWrapper((SafeArena arena) {
      final ffi.Pointer<bindings.CBS> cbsPtr = arena.allocate<bindings.CBS>(
        ffi.sizeOf<bindings.CBS>(),
      );
      cbsPtr.ref.data = remotePublicKey.toFFIPointer(arena);
      cbsPtr.ref.len = remotePublicKey.length;
      final publicKeyPtr = arena.allocate<bindings.KYBER_public_key>(
        // bindings.KYBER_PUBLIC_KEY_BYTES,
        ffi.sizeOf<bindings.KYBER_public_key>()
      );
      final result = ffiBindings.KYBER_parse_public_key(publicKeyPtr, cbsPtr);

      if (result == 0) {
        logger.log("KyberSession._encapsulate: failed to parse public key");
        return null;
      }

      // we need to apply keccak to the entropy first
      final hashedEntropy = keccak.keccak256.hash(entropy);

      if (hashedEntropy == null) {
        logger.log("Kyber._encapsulateExternalEntropy: Unable to hash the entropy");
        return null;
      }

      final entropyPtr = hashedEntropy.toFFIPointer(arena);
      final cipherPtr = arena.allocate<ffi.Uint8>(
        bindings.KYBER_CIPHERTEXT_BYTES,
      );
      final sharedSecretPtr = arena.allocate<ffi.Uint8>(
        bindings.KYBER_SHARED_SECRET_BYTES,
      );
      ffiBindings.KYBER_encap_external_entropy(cipherPtr, sharedSecretPtr, publicKeyPtr, entropyPtr);

      return (
        cipher: returnUint8List(cipherPtr, bindings.KYBER_CIPHERTEXT_BYTES),
        sharedSecret: returnUint8List(
          sharedSecretPtr,
          bindings.KYBER_SHARED_SECRET_BYTES,
        ),
      );
    });
  }
}
