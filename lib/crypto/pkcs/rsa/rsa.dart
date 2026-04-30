import 'dart:ffi' as ffi;
import 'dart:typed_data';
import 'package:boringssl_ffi/src/bindings/bindings.dart' as bindings;
import 'package:boringssl_ffi/src/ffi_lib/ffi_lib.dart';
import 'package:boringssl_ffi/src/helpers/conversion/list_to_bytearray.dart';
import 'package:boringssl_ffi/src/helpers/evp/md_evp.dart';
import 'package:boringssl_ffi/src/logging/logging.dart';

part 'rsa_padding.dart';

const rsa = RSA();

class RSA {
  const RSA();

  static const F4 = 0x10001;

  // returns RSA public key set in DER format
  ({Uint8List privateKey, Uint8List publicKey})? generateKeySet(
    int bits, [
    int exponent = RSA.F4,
  ]) {
    return arenaWrapper((SafeArena arena) {
      final rsaPtr = arena.using(
        ffiBindings.RSA_new(),
        ffiBindings.RSA_free, // Called automatically on arena exit!
      );

      final ePrt = _getBigNumPointer(exponent, arena);
      if (ePrt == null) {
        return null;
      }

      // final cbPointer = arena.allocate<bindings.BN_GENCB>(ffi.sizeOf<bindings.BN_GENCB>());

      final result = ffiBindings.RSA_generate_key_ex(
        rsaPtr,
        bits,
        ePrt,
        ffi.nullptr,
      );

      // Check if the call was successful.
      if (result != 1) {
        logger.log(
          "RSA.generateKeySet: RSA_generate_key_ex function call failed",
        );
        return null;
      }

      // Prepare pointers for the DER extraction
      final privOutBytesPtr = arena.allocate<ffi.Pointer<ffi.Uint8>>(
        ffi.sizeOf<ffi.Pointer<ffi.Uint8>>(),
      );
      final privOutLenPtr = arena.allocate<ffi.Size>(ffi.sizeOf<ffi.Size>());

      final pubOutBytesPtr = arena.allocate<ffi.Pointer<ffi.Uint8>>(
        ffi.sizeOf<ffi.Pointer<ffi.Uint8>>(),
      );
      final pubOutLenPtr = arena.allocate<ffi.Size>(ffi.sizeOf<ffi.Size>());

      // Extract Private Key bytes
      if (ffiBindings.RSA_private_key_to_bytes(
            privOutBytesPtr,
            privOutLenPtr,
            rsaPtr,
          ) !=
          1) {
        logger.log("RSA.generateKeySet: RSA_private_key_to_bytes failed");
        return null;
      }

      // Extract Public Key bytes
      if (ffiBindings.RSA_public_key_to_bytes(
            pubOutBytesPtr,
            pubOutLenPtr,
            rsaPtr,
          ) !=
          1) {
        ffiBindings.OPENSSL_free(privOutBytesPtr.value.cast<ffi.Void>());
        logger.log("RSA.generateKeySet: RSA_public_key_to_bytes failed");
        return null;
      }

      // Clone the bytes into Dart-owned Uint8List using your helper
      final privateKey = returnUint8List(
        privOutBytesPtr.value,
        privOutLenPtr.value,
      );
      final publicKey = returnUint8List(
        pubOutBytesPtr.value,
        pubOutLenPtr.value,
      );

      // CRITICAL: Free the BoringSSL internal buffers allocated by the _to_bytes functions
      ffiBindings.OPENSSL_free(privOutBytesPtr.value.cast<ffi.Void>());
      ffiBindings.OPENSSL_free(pubOutBytesPtr.value.cast<ffi.Void>());

      return (privateKey: privateKey, publicKey: publicKey);
    });
  }

  // returns RSA public key set in DER format
  // IMPORTANT: `bits` accepted values are 2048, 3072 or 4096
  ({Uint8List privateKey, Uint8List publicKey})? generateKeySetFIPS(int bits) {
    if (bits != 2048 && bits != 3072 && bits != 4096) {
      return null;
    }
    return arenaWrapper((SafeArena arena) {
      final rsaPtr = arena.using(
        ffiBindings.RSA_new(),
        ffiBindings.RSA_free, // Called automatically on arena exit!
      );

      // final cbPointer = arena.allocate<bindings.BN_GENCB>(ffi.sizeOf<bindings.BN_GENCB>());

      final result = ffiBindings.RSA_generate_key_fips(
        rsaPtr,
        bits,
        ffi.nullptr,
      );

      // Check if the call was successful.
      if (result != 1) {
        logger.log(
          "RSA.generateKeySet: RSA_generate_key_ex function call failed",
        );
        return null;
      }

      // Prepare pointers for the DER extraction
      final privOutBytesPtr = arena.allocate<ffi.Pointer<ffi.Uint8>>(
        ffi.sizeOf<ffi.Pointer<ffi.Uint8>>(),
      );
      final privOutLenPtr = arena.allocate<ffi.Size>(ffi.sizeOf<ffi.Size>());

      final pubOutBytesPtr = arena.allocate<ffi.Pointer<ffi.Uint8>>(
        ffi.sizeOf<ffi.Pointer<ffi.Uint8>>(),
      );
      final pubOutLenPtr = arena.allocate<ffi.Size>(ffi.sizeOf<ffi.Size>());

      // Extract Private Key bytes
      if (ffiBindings.RSA_private_key_to_bytes(
            privOutBytesPtr,
            privOutLenPtr,
            rsaPtr,
          ) !=
          1) {
        logger.log("RSA.generateKeySet: RSA_private_key_to_bytes failed");
        return null;
      }

      // Extract Public Key bytes
      if (ffiBindings.RSA_public_key_to_bytes(
            pubOutBytesPtr,
            pubOutLenPtr,
            rsaPtr,
          ) !=
          1) {
        ffiBindings.OPENSSL_free(privOutBytesPtr.value.cast<ffi.Void>());
        logger.log("RSA.generateKeySet: RSA_public_key_to_bytes failed");
        return null;
      }

      // Clone the bytes into Dart-owned Uint8List using your helper
      final privateKey = returnUint8List(
        privOutBytesPtr.value,
        privOutLenPtr.value,
      );
      final publicKey = returnUint8List(
        pubOutBytesPtr.value,
        pubOutLenPtr.value,
      );

      // CRITICAL: Free the BoringSSL internal buffers allocated by the _to_bytes functions
      ffiBindings.OPENSSL_free(privOutBytesPtr.value.cast<ffi.Void>());
      ffiBindings.OPENSSL_free(pubOutBytesPtr.value.cast<ffi.Void>());

      return (privateKey: privateKey, publicKey: publicKey);
    });
  }

  Uint8List? _encrypt(
    List<int> publicKeyDer,
    List<int> input,
    _RSAPadding padding, {
    HashAlgorithm hashAlgorithm = HashAlgorithm.sha1,
    HashAlgorithm mgf1Hash = HashAlgorithm.sha1,
    List<int>? label,
  }) {
    return arenaWrapper((SafeArena arena) {
      final pubKeyBytesPtr = publicKeyDer.toUint8List().toFFIPointer(arena);

      // 1. Parse RSA Public Key (Do NOT put in arena.using yet)
      final rsaPtr = ffiBindings.RSA_public_key_from_bytes(
        pubKeyBytesPtr,
        publicKeyDer.length,
      );
      if (rsaPtr == ffi.nullptr) {
        logger.log("RSA.encrypt: Failed to parse public key bytes");
        return null;
      }

      // 2. Create the envelope and assign RSA
      final pkey = arena.using(
        ffiBindings.EVP_PKEY_new(),
        ffiBindings.EVP_PKEY_free,
      );
      ffiBindings.EVP_PKEY_assign_RSA(pkey, rsaPtr);

      // 3. Create the context
      final ctx = arena.using(
        ffiBindings.EVP_PKEY_CTX_new(pkey, ffi.nullptr),
        ffiBindings.EVP_PKEY_CTX_free,
      );

      // CRITICAL DIFFERENCE: Initialize for ENCRYPTION
      ffiBindings.EVP_PKEY_encrypt_init(ctx);

      ffiBindings.EVP_PKEY_CTX_set_rsa_padding(ctx, padding.value);

      // 4. Apply OAEP Hashes and Labels
      if (padding == _RSAPadding.RSA_PKCS1_OAEP_PADDING) {
        ffiBindings.EVP_PKEY_CTX_set_rsa_oaep_md(ctx, hashAlgorithm.objectPtr);
        ffiBindings.EVP_PKEY_CTX_set_rsa_mgf1_md(ctx, mgf1Hash.objectPtr);

        // Safely handle the label using OPENSSL_malloc
        if (label != null && label.isNotEmpty) {
          final cLabel = ffiBindings.OPENSSL_malloc(
            label.length,
          ).cast<ffi.Uint8>();
          if (cLabel == ffi.nullptr) return null;

          final cLabelList = cLabel.asTypedList(label.length);
          cLabelList.setAll(0, label);

          // set0 takes ownership. If it fails, we free it.
          final labelSuccess = ffiBindings.EVP_PKEY_CTX_set0_rsa_oaep_label(
            ctx,
            cLabel,
            label.length,
          );
          if (labelSuccess != 1) {
            ffiBindings.OPENSSL_free(cLabel.cast<ffi.Void>());
            return null;
          }
        }
      }

      // 5. Setup buffers and execute
      final rsaSize = ffiBindings.RSA_size(rsaPtr);
      final outputPtr = arena.allocate<ffi.Uint8>(rsaSize);

      final outputSizePtr = arena.allocate<ffi.Size>(ffi.sizeOf<ffi.Size>());
      outputSizePtr.value =
          rsaSize; // MUST set the max buffer capacity for EVP!

      final inputPtr = input.toUint8List().toFFIPointer(arena);

      // CRITICAL DIFFERENCE: Call EVP_PKEY_encrypt
      final result = ffiBindings.EVP_PKEY_encrypt(
        ctx,
        outputPtr,
        outputSizePtr,
        inputPtr,
        input.length,
      );

      if (result != 1) {
        logger.log("RSA.encrypt: EVP_PKEY_encrypt function call failed");
        return null;
      }

      // outputSizePtr.value now holds the EXACT length of the resulting ciphertext
      return returnUint8List(outputPtr, outputSizePtr.value);
    });
  }

  Uint8List? encryptSHA1NoPadding(List<int> publicKeyDer, List<int> input) {
    return _encrypt(
      publicKeyDer,
      input,
      _RSAPadding.RSA_NO_PADDING,
      hashAlgorithm: HashAlgorithm.sha1,
    );
  }

  Uint8List? encryptSHA1PKCS1_OAEP(
    List<int> publicKeyDer,
    List<int> input, {
    List<int>? label,
  }) {
    return _encrypt(
      publicKeyDer,
      input,
      _RSAPadding.RSA_PKCS1_OAEP_PADDING,
      hashAlgorithm: HashAlgorithm.sha1,
      label: label,
    );
  }

  @Deprecated("PKCS1 padding is insecure. If unsure, use PKCS1_OAEP padding")
  Uint8List? encryptSHA1PKCS1(List<int> publicKeyDer, List<int> input) {
    return _encrypt(
      publicKeyDer,
      input,
      _RSAPadding.RSA_PKCS1_PADDING,
      hashAlgorithm: HashAlgorithm.sha1,
    );
  }

  Uint8List? encryptSHA224NoPadding(List<int> publicKeyDer, List<int> input) {
    return _encrypt(
      publicKeyDer,
      input,
      _RSAPadding.RSA_NO_PADDING,
      hashAlgorithm: HashAlgorithm.sha224,
    );
  }

  Uint8List? encryptSHA224PKCS1_OAEP(
    List<int> publicKeyDer,
    List<int> input, {
    List<int>? label,
    bool useSHA1ForMGF1 = false,
  }) {
    return _encrypt(
      publicKeyDer,
      input,
      _RSAPadding.RSA_PKCS1_OAEP_PADDING,
      hashAlgorithm: HashAlgorithm.sha224,
      mgf1Hash: useSHA1ForMGF1 ? HashAlgorithm.sha1 : HashAlgorithm.sha224,
      label: label,
    );
  }

  @Deprecated("PKCS1 padding is insecure. If unsure, use PKCS1_OAEP padding")
  Uint8List? encryptSHA224PKCS1(List<int> publicKeyDer, List<int> input) {
    return _encrypt(
      publicKeyDer,
      input,
      _RSAPadding.RSA_PKCS1_PADDING,
      hashAlgorithm: HashAlgorithm.sha224,
    );
  }

  Uint8List? encryptSHA256NoPadding(List<int> publicKeyDer, List<int> input) {
    return _encrypt(
      publicKeyDer,
      input,
      _RSAPadding.RSA_NO_PADDING,
      hashAlgorithm: HashAlgorithm.sha256,
    );
  }

  Uint8List? encryptSHA256PKCS1_OAEP(
    List<int> publicKeyDer,
    List<int> input, {
    List<int>? label,
    bool useSHA1ForMGF1 = false,
  }) {
    return _encrypt(
      publicKeyDer,
      input,
      _RSAPadding.RSA_PKCS1_OAEP_PADDING,
      hashAlgorithm: HashAlgorithm.sha256,
      mgf1Hash: useSHA1ForMGF1 ? HashAlgorithm.sha1 : HashAlgorithm.sha256,
      label: label,
    );
  }

  @Deprecated("PKCS1 padding is insecure. If unsure, use PKCS1_OAEP padding")
  Uint8List? encryptSHA256PKCS1(List<int> publicKeyDer, List<int> input) {
    return _encrypt(
      publicKeyDer,
      input,
      _RSAPadding.RSA_PKCS1_PADDING,
      hashAlgorithm: HashAlgorithm.sha256,
    );
  }

  Uint8List? encryptSHA384NoPadding(List<int> publicKeyDer, List<int> input) {
    return _encrypt(
      publicKeyDer,
      input,
      _RSAPadding.RSA_NO_PADDING,
      hashAlgorithm: HashAlgorithm.sha384,
    );
  }

  Uint8List? encryptSHA384PKCS1_OAEP(
    List<int> publicKeyDer,
    List<int> input, {
    List<int>? label,
    bool useSHA1ForMGF1 = false,
  }) {
    return _encrypt(
      publicKeyDer,
      input,
      _RSAPadding.RSA_PKCS1_OAEP_PADDING,
      hashAlgorithm: HashAlgorithm.sha384,
      mgf1Hash: useSHA1ForMGF1 ? HashAlgorithm.sha1 : HashAlgorithm.sha384,
      label: label,
    );
  }

  @Deprecated("PKCS1 padding is insecure. If unsure, use PKCS1_OAEP padding")
  Uint8List? encryptSHA384PKCS1(List<int> publicKeyDer, List<int> input) {
    return _encrypt(
      publicKeyDer,
      input,
      _RSAPadding.RSA_PKCS1_PADDING,
      hashAlgorithm: HashAlgorithm.sha384,
    );
  }

  Uint8List? encryptSHA512NoPadding(List<int> publicKeyDer, List<int> input) {
    return _encrypt(
      publicKeyDer,
      input,
      _RSAPadding.RSA_NO_PADDING,
      hashAlgorithm: HashAlgorithm.sha512,
    );
  }

  Uint8List? encryptSHA512PKCS1_OAEP(
    List<int> publicKeyDer,
    List<int> input, {
    List<int>? label,
    bool useSHA1ForMGF1 = false,
  }) {
    return _encrypt(
      publicKeyDer,
      input,
      _RSAPadding.RSA_PKCS1_OAEP_PADDING,
      hashAlgorithm: HashAlgorithm.sha512,
      mgf1Hash: useSHA1ForMGF1 ? HashAlgorithm.sha1 : HashAlgorithm.sha512,
      label: label,
    );
  }

  @Deprecated("PKCS1 padding is insecure. If unsure, use PKCS1_OAEP padding")
  Uint8List? encryptSHA512PKCS1(List<int> publicKeyDer, List<int> input) {
    return _encrypt(
      publicKeyDer,
      input,
      _RSAPadding.RSA_PKCS1_PADDING,
      hashAlgorithm: HashAlgorithm.sha512,
    );
  }

  Uint8List? encryptSHA512_256NoPadding(List<int> publicKeyDer, List<int> input) {
    return _encrypt(
      publicKeyDer,
      input,
      _RSAPadding.RSA_NO_PADDING,
      hashAlgorithm: HashAlgorithm.sha512_256,
    );
  }

  Uint8List? encryptSHA512_256PKCS1_OAEP(
    List<int> publicKeyDer,
    List<int> input, {
    List<int>? label,
    bool useSHA1ForMGF1 = false,
  }) {
    return _encrypt(
      publicKeyDer,
      input,
      _RSAPadding.RSA_PKCS1_OAEP_PADDING,
      hashAlgorithm: HashAlgorithm.sha512_256,
      mgf1Hash: useSHA1ForMGF1 ? HashAlgorithm.sha1 : HashAlgorithm.sha512_256,
      label: label,
    );
  }

  @Deprecated("PKCS1 padding is insecure. If unsure, use PKCS1_OAEP padding")
  Uint8List? encryptSHA512_256PKCS1(List<int> publicKeyDer, List<int> input) {
    return _encrypt(
      publicKeyDer,
      input,
      _RSAPadding.RSA_PKCS1_PADDING,
      hashAlgorithm: HashAlgorithm.sha512_256,
    );
  }

  /// WARNING: Passing RSAPadding.RSA_PKCS1_PADDING into this function is deprecated and insecure.
  /// RSAES-PKCS1-v1_5 is vulnerable to a chosen-ciphertext attack. Decrypting attacker-supplied
  /// ciphertext with RSAES-PKCS1-v1_5 may give the attacker control over your private key.
  /// See "Chosen Ciphertext Attacks Against Protocols Based on the RSA Encryption Standard PKCS #1",
  /// Daniel Bleichenbacher, Advances in Cryptology (Crypto '98).
  Uint8List? _decrypt(
    List<int> privateKeyDer,
    List<int> input,
    _RSAPadding padding, {
    HashAlgorithm hashAlgorithm = HashAlgorithm.sha1,
    HashAlgorithm mgf1Hash = HashAlgorithm.sha1,
    List<int>? label,
  }) {
    return arenaWrapper((SafeArena arena) {
      final privKeyBytesPtr = privateKeyDer.toUint8List().toFFIPointer(arena);
      final rsaPtr = ffiBindings.RSA_private_key_from_bytes(
        privKeyBytesPtr,
        privateKeyDer.length,
      );

      if (rsaPtr == ffi.nullptr) {
        logger.log("RSA.decrypt: Failed to parse private key bytes");
        return null;
      }

      // create the envelope
      final pkey = arena.using(
        ffiBindings.EVP_PKEY_new(),
        ffiBindings.EVP_PKEY_free,
      );
      ffiBindings.EVP_PKEY_assign_RSA(pkey, rsaPtr);

      final ctx = arena.using(
        ffiBindings.EVP_PKEY_CTX_new(pkey, ffi.nullptr),
        ffiBindings.EVP_PKEY_CTX_free,
      );
      ffiBindings.EVP_PKEY_decrypt_init(ctx);
      ffiBindings.EVP_PKEY_CTX_set_rsa_padding(ctx, padding.value);

      if (padding == _RSAPadding.RSA_PKCS1_OAEP_PADDING) {
        ffiBindings.EVP_PKEY_CTX_set_rsa_oaep_md(ctx, hashAlgorithm.objectPtr);
        ffiBindings.EVP_PKEY_CTX_set_rsa_mgf1_md(ctx, mgf1Hash.objectPtr);

        // 6. Safely handle the label using OPENSSL_malloc
        if (label != null && label.isNotEmpty) {
          final cLabel = ffiBindings.OPENSSL_malloc(
            label.length,
          ).cast<ffi.Uint8>();
          if (cLabel == ffi.nullptr) return null;

          final cLabelList = cLabel.asTypedList(label.length);
          cLabelList.setAll(0, label);

          // set0 takes ownership of cLabel. If it fails, we must free it ourselves.
          final labelSuccess = ffiBindings.EVP_PKEY_CTX_set0_rsa_oaep_label(
            ctx,
            cLabel,
            label.length,
          );
          if (labelSuccess != 1) {
            ffiBindings.OPENSSL_free(cLabel.cast<ffi.Void>());
            return null;
          }
        }
      }

      final rsaSize = ffiBindings.RSA_size(rsaPtr);
      final outputPtr = arena.allocate<ffi.Uint8>(rsaSize);
      final outputSizePtr = arena.allocate<ffi.Size>(ffi.sizeOf<ffi.Size>());
      outputSizePtr.value = rsaSize;

      final inputPtr = input.toUint8List().toFFIPointer(arena);

      final result = ffiBindings.EVP_PKEY_decrypt(
        ctx,
        outputPtr,
        outputSizePtr,
        inputPtr,
        input.length,
      );

      if (result != 1) {
        logger.log("RSA.EVP_PKEY_decrypt: RSA_decrypt function call failed");
        return null;
      }

      // outputSizePtr.value now holds the EXACT length of the recovered plaintext
      return returnUint8List(outputPtr, outputSizePtr.value);
    });
  }

  Uint8List? decryptSHA1NoPadding(
    List<int> privateKeyDer,
    List<int> input, {
    List<int>? label,
  }) {
    return _decrypt(
      privateKeyDer,
      input,
      _RSAPadding.RSA_NO_PADDING,
      hashAlgorithm: HashAlgorithm.sha1,
      label: label,
    );
  }

  Uint8List? decryptSHA1PKCS1_OAEP(
    List<int> privateKeyDer,
    List<int> input, {
    List<int>? label,
  }) {
    return _decrypt(
      privateKeyDer,
      input,
      _RSAPadding.RSA_PKCS1_OAEP_PADDING,
      hashAlgorithm: HashAlgorithm.sha1,
      mgf1Hash: HashAlgorithm.sha1,
      label: label,
    );
  }

  // WARNING: this function is deprecated and insecure.
  /// RSAES-PKCS1-v1_5 is vulnerable to a chosen-ciphertext attack. Decrypting attacker-supplied
  /// ciphertext with RSAES-PKCS1-v1_5 may give the attacker control over your private key.
  /// See "Chosen Ciphertext Attacks Against Protocols Based on the RSA Encryption Standard PKCS #1",
  /// Daniel Bleichenbacher, Advances in Cryptology (Crypto '98).
  @Deprecated("PKCS1 padding is insecure. If unsure, use PKCS1_OAEP padding")
  Uint8List? decryptSHA1PKCS1(
    List<int> privateKeyDer,
    List<int> input, {
    List<int>? label,
  }) {
    return _decrypt(
      privateKeyDer,
      input,
      _RSAPadding.RSA_PKCS1_PADDING,
      hashAlgorithm: HashAlgorithm.sha1,
      label: label,
    );
  }

  Uint8List? decryptSHA224NoPadding(
    List<int> privateKeyDer,
    List<int> input, {
    List<int>? label,
  }) {
    return _decrypt(
      privateKeyDer,
      input,
      _RSAPadding.RSA_NO_PADDING,
      hashAlgorithm: HashAlgorithm.sha224,
      label: label,
    );
  }

  Uint8List? decryptSHA224PKCS1_OAEP(
    List<int> privateKeyDer,
    List<int> input, {
    List<int>? label,
    bool useSHA1ForMGF1 = false,
  }) {
    return _decrypt(
      privateKeyDer,
      input,
      _RSAPadding.RSA_PKCS1_OAEP_PADDING,
      hashAlgorithm: HashAlgorithm.sha224,
      mgf1Hash: useSHA1ForMGF1 ? HashAlgorithm.sha1 : HashAlgorithm.sha224,
      label: label,
    );
  }

  // WARNING: this function is deprecated and insecure.
  /// RSAES-PKCS1-v1_5 is vulnerable to a chosen-ciphertext attack. Decrypting attacker-supplied
  /// ciphertext with RSAES-PKCS1-v1_5 may give the attacker control over your private key.
  /// See "Chosen Ciphertext Attacks Against Protocols Based on the RSA Encryption Standard PKCS #1",
  /// Daniel Bleichenbacher, Advances in Cryptology (Crypto '98).
  @Deprecated("PKCS1 padding is insecure. If unsure, use PKCS1_OAEP padding")
  Uint8List? decryptSHA224PKCS1(
    List<int> privateKeyDer,
    List<int> input, {
    List<int>? label,
  }) {
    return _decrypt(
      privateKeyDer,
      input,
      _RSAPadding.RSA_PKCS1_PADDING,
      hashAlgorithm: HashAlgorithm.sha224,
      label: label,
    );
  }

  Uint8List? decryptSHA256NoPadding(
    List<int> privateKeyDer,
    List<int> input, {
    List<int>? label,
  }) {
    return _decrypt(
      privateKeyDer,
      input,
      _RSAPadding.RSA_NO_PADDING,
      hashAlgorithm: HashAlgorithm.sha256,
      label: label,
    );
  }

  Uint8List? decryptSHA256PKCS1_OAEP(
    List<int> privateKeyDer,
    List<int> input, {
    List<int>? label,
    bool useSHA1ForMGF1 = false,
  }) {
    return _decrypt(
      privateKeyDer,
      input,
      _RSAPadding.RSA_PKCS1_OAEP_PADDING,
      hashAlgorithm: HashAlgorithm.sha256,
      mgf1Hash: useSHA1ForMGF1 ? HashAlgorithm.sha1 : HashAlgorithm.sha256,
      label: label,
    );
  }

  // WARNING: this function is deprecated and insecure.
  /// RSAES-PKCS1-v1_5 is vulnerable to a chosen-ciphertext attack. Decrypting attacker-supplied
  /// ciphertext with RSAES-PKCS1-v1_5 may give the attacker control over your private key.
  /// See "Chosen Ciphertext Attacks Against Protocols Based on the RSA Encryption Standard PKCS #1",
  /// Daniel Bleichenbacher, Advances in Cryptology (Crypto '98).
  @Deprecated("PKCS1 padding is insecure. If unsure, use PKCS1_OAEP padding")
  Uint8List? decryptSHA256PKCS1(
    List<int> privateKeyDer,
    List<int> input, {
    List<int>? label,
  }) {
    return _decrypt(
      privateKeyDer,
      input,
      _RSAPadding.RSA_PKCS1_PADDING,
      hashAlgorithm: HashAlgorithm.sha256,
      label: label,
    );
  }

  Uint8List? decryptSHA384NoPadding(
    List<int> privateKeyDer,
    List<int> input, {
    List<int>? label,
  }) {
    return _decrypt(
      privateKeyDer,
      input,
      _RSAPadding.RSA_NO_PADDING,
      hashAlgorithm: HashAlgorithm.sha384,
      label: label,
    );
  }

  Uint8List? decryptSHA384PKCS1_OAEP(
    List<int> privateKeyDer,
    List<int> input, {
    List<int>? label,
    bool useSHA1ForMGF1 = false,
  }) {
    return _decrypt(
      privateKeyDer,
      input,
      _RSAPadding.RSA_PKCS1_OAEP_PADDING,
      hashAlgorithm: HashAlgorithm.sha384,
      mgf1Hash: useSHA1ForMGF1 ? HashAlgorithm.sha1 : HashAlgorithm.sha384,
      label: label,
    );
  }

  // WARNING: this function is deprecated and insecure.
  /// RSAES-PKCS1-v1_5 is vulnerable to a chosen-ciphertext attack. Decrypting attacker-supplied
  /// ciphertext with RSAES-PKCS1-v1_5 may give the attacker control over your private key.
  /// See "Chosen Ciphertext Attacks Against Protocols Based on the RSA Encryption Standard PKCS #1",
  /// Daniel Bleichenbacher, Advances in Cryptology (Crypto '98).
  @Deprecated("PKCS1 padding is insecure. If unsure, use PKCS1_OAEP padding")
  Uint8List? decryptSHA384PKCS1(
    List<int> privateKeyDer,
    List<int> input, {
    List<int>? label,
  }) {
    return _decrypt(
      privateKeyDer,
      input,
      _RSAPadding.RSA_PKCS1_PADDING,
      hashAlgorithm: HashAlgorithm.sha384,
      label: label,
    );
  }

  Uint8List? decryptSHA512NoPadding(
    List<int> privateKeyDer,
    List<int> input, {
    List<int>? label,
  }) {
    return _decrypt(
      privateKeyDer,
      input,
      _RSAPadding.RSA_NO_PADDING,
      hashAlgorithm: HashAlgorithm.sha512,
      label: label,
    );
  }

  Uint8List? decryptSHA512PKCS1_OAEP(
    List<int> privateKeyDer,
    List<int> input, {
    List<int>? label,
    bool useSHA1ForMGF1 = false,
  }) {
    return _decrypt(
      privateKeyDer,
      input,
      _RSAPadding.RSA_PKCS1_OAEP_PADDING,
      hashAlgorithm: HashAlgorithm.sha512,
      mgf1Hash: useSHA1ForMGF1 ? HashAlgorithm.sha1 : HashAlgorithm.sha512,
      label: label,
    );
  }

  // WARNING: this function is deprecated and insecure.
  /// RSAES-PKCS1-v1_5 is vulnerable to a chosen-ciphertext attack. Decrypting attacker-supplied
  /// ciphertext with RSAES-PKCS1-v1_5 may give the attacker control over your private key.
  /// See "Chosen Ciphertext Attacks Against Protocols Based on the RSA Encryption Standard PKCS #1",
  /// Daniel Bleichenbacher, Advances in Cryptology (Crypto '98).
  @Deprecated("PKCS1 padding is insecure. If unsure, use PKCS1_OAEP padding")
  Uint8List? decryptSHA512PKCS1(
    List<int> privateKeyDer,
    List<int> input, {
    List<int>? label,
  }) {
    return _decrypt(
      privateKeyDer,
      input,
      _RSAPadding.RSA_PKCS1_PADDING,
      hashAlgorithm: HashAlgorithm.sha512,
      label: label,
    );
  }

  Uint8List? decryptSHA512_256NoPadding(
    List<int> privateKeyDer,
    List<int> input, {
    List<int>? label,
  }) {
    return _decrypt(
      privateKeyDer,
      input,
      _RSAPadding.RSA_NO_PADDING,
      hashAlgorithm: HashAlgorithm.sha512_256,
      label: label,
    );
  }

  Uint8List? decryptSHA512_256PKCS1_OAEP(
    List<int> privateKeyDer,
    List<int> input, {
    List<int>? label,
    bool useSHA1ForMGF1 = false,
  }) {
    return _decrypt(
      privateKeyDer,
      input,
      _RSAPadding.RSA_PKCS1_OAEP_PADDING,
      hashAlgorithm: HashAlgorithm.sha512_256,
      mgf1Hash: useSHA1ForMGF1 ? HashAlgorithm.sha1 : HashAlgorithm.sha512_256,
      label: label,
    );
  }

  // WARNING: this function is deprecated and insecure.
  /// RSAES-PKCS1-v1_5 is vulnerable to a chosen-ciphertext attack. Decrypting attacker-supplied
  /// ciphertext with RSAES-PKCS1-v1_5 may give the attacker control over your private key.
  /// See "Chosen Ciphertext Attacks Against Protocols Based on the RSA Encryption Standard PKCS #1",
  /// Daniel Bleichenbacher, Advances in Cryptology (Crypto '98).
  @Deprecated("PKCS1 padding is insecure. If unsure, use PKCS1_OAEP padding")
  Uint8List? decryptSHA512_256PKCS1(
    List<int> privateKeyDer,
    List<int> input, {
    List<int>? label,
  }) {
    return _decrypt(
      privateKeyDer,
      input,
      _RSAPadding.RSA_PKCS1_PADDING,
      hashAlgorithm: HashAlgorithm.sha512_256,
      label: label,
    );
  }

  /// Supported padding type are `RSA_PKCS1_PSS_PADDING` or `RSA_PKCS1_PADDING`
  Uint8List? _sign(
    List<int> privateKeyDer,
    List<int> digest,
    HashAlgorithm hashAlg,
    _RSAPadding padding,
  ) {
    if (padding != _RSAPadding.RSA_PKCS1_PSS_PADDING &&
        padding != _RSAPadding.RSA_PKCS1_PADDING) {
      logger.log(
        "RSA.sign: Unsupported padding scheme for signing. Supported paddings are `RSA_PKCS1_PSS_PADDING` or `RSA_PKCS1_PADDING`",
      );
      return null;
    }
    return arenaWrapper((SafeArena arena) {
      final privKeyBytesPtr = privateKeyDer.toUint8List().toFFIPointer(arena);
      final rsaPtr = arena.using(
        ffiBindings.RSA_private_key_from_bytes(
          privKeyBytesPtr,
          privateKeyDer.length,
        ),
        ffiBindings.RSA_free,
      );

      if (rsaPtr == ffi.nullptr) {
        logger.log("RSA.sign: Failed to parse private key bytes");
        return null;
      }

      final rsaSize = ffiBindings.RSA_size(rsaPtr);
      final outputPtr = arena.allocate<ffi.Uint8>(rsaSize);

      final outLenUnsignedPtr = arena.allocate<ffi.UnsignedInt>(
        ffi.sizeOf<ffi.UnsignedInt>(),
      );
      final outLenSizePtr = arena.allocate<ffi.Size>(ffi.sizeOf<ffi.Size>());

      final digestPtr = digest.toUint8List().toFFIPointer(arena);

      int result = 0;
      int finalSigLength = 0;

      if (padding == _RSAPadding.RSA_PKCS1_PADDING) {
        // Legacy PKCS#1 v1.5 (Uses the NID)
        result = ffiBindings.RSA_sign(
          hashAlg.envNID,
          digestPtr,
          digest.length,
          outputPtr,
          outLenUnsignedPtr,
          rsaPtr,
        );
        finalSigLength = outLenUnsignedPtr.value;
      } else if (padding == _RSAPadding.RSA_PKCS1_PSS_PADDING) {
        // Modern PSS (Uses the EVP_MD pointer)
        // -1 (RSA_PSS_SALTLEN_DIGEST) means salt length matches the hash length (Recommended)
        result = ffiBindings.RSA_sign_pss_mgf1(
          rsaPtr,
          outLenSizePtr,
          outputPtr,
          rsaSize,
          digestPtr,
          digest.length,
          hashAlg.objectPtr,
          ffi.nullptr, // mgf1_md (nullptr means use the same hash alg)
          -1, // salt_len
        );
        finalSigLength = outLenSizePtr.value;
      }

      if (result != 1) {
        logger.log("RSA.sign: Signature generation failed");
        return null;
      }

      return returnUint8List(outputPtr, finalSigLength);
    });
  }

  Uint8List? signSHA1DigestPKCS1(List<int> privateKeyDer, List<int> digest) {
    return _sign(
      privateKeyDer,
      digest,
      HashAlgorithm.sha1,
      _RSAPadding.RSA_PKCS1_PADDING,
    );
  }

  Uint8List? signSHA1DigestPKCS1_PSS(
    List<int> privateKeyDer,
    List<int> digest,
  ) {
    return _sign(
      privateKeyDer,
      digest,
      HashAlgorithm.sha1,
      _RSAPadding.RSA_PKCS1_PSS_PADDING,
    );
  }

  Uint8List? signSHA224DigestPKCS1(List<int> privateKeyDer, List<int> digest) {
    return _sign(
      privateKeyDer,
      digest,
      HashAlgorithm.sha224,
      _RSAPadding.RSA_PKCS1_PADDING,
    );
  }

  Uint8List? signSHA224DigestPKCS1_PSS(
    List<int> privateKeyDer,
    List<int> digest,
  ) {
    return _sign(
      privateKeyDer,
      digest,
      HashAlgorithm.sha224,
      _RSAPadding.RSA_PKCS1_PSS_PADDING,
    );
  }

  Uint8List? signSHA256DigestPKCS1(List<int> privateKeyDer, List<int> digest) {
    return _sign(
      privateKeyDer,
      digest,
      HashAlgorithm.sha256,
      _RSAPadding.RSA_PKCS1_PADDING,
    );
  }

  Uint8List? signSHA256DigestPKCS1_PSS(
    List<int> privateKeyDer,
    List<int> digest,
  ) {
    return _sign(
      privateKeyDer,
      digest,
      HashAlgorithm.sha256,
      _RSAPadding.RSA_PKCS1_PSS_PADDING,
    );
  }

  Uint8List? signSHA384DigestPKCS1(List<int> privateKeyDer, List<int> digest) {
    return _sign(
      privateKeyDer,
      digest,
      HashAlgorithm.sha384,
      _RSAPadding.RSA_PKCS1_PADDING,
    );
  }

  Uint8List? signSHA384DigestPKCS1_PSS(
    List<int> privateKeyDer,
    List<int> digest,
  ) {
    return _sign(
      privateKeyDer,
      digest,
      HashAlgorithm.sha384,
      _RSAPadding.RSA_PKCS1_PSS_PADDING,
    );
  }

  Uint8List? signSHA512DigestPKCS1(List<int> privateKeyDer, List<int> digest) {
    return _sign(
      privateKeyDer,
      digest,
      HashAlgorithm.sha512,
      _RSAPadding.RSA_PKCS1_PADDING,
    );
  }

  Uint8List? signSHA512DigestPKCS1_PSS(
    List<int> privateKeyDer,
    List<int> digest,
  ) {
    return _sign(
      privateKeyDer,
      digest,
      HashAlgorithm.sha512,
      _RSAPadding.RSA_PKCS1_PSS_PADDING,
    );
  }

  Uint8List? signSHA512_256DigestPKCS1(
    List<int> privateKeyDer,
    List<int> digest,
  ) {
    return _sign(
      privateKeyDer,
      digest,
      HashAlgorithm.sha512_256,
      _RSAPadding.RSA_PKCS1_PADDING,
    );
  }

  Uint8List? signSHA512_256DigestPKCS1_PSS(
    List<int> privateKeyDer,
    List<int> digest,
  ) {
    return _sign(
      privateKeyDer,
      digest,
      HashAlgorithm.sha512_256,
      _RSAPadding.RSA_PKCS1_PSS_PADDING,
    );
  }

  /// Supported padding types are `RSA_PKCS1_PSS_PADDING` or `RSA_PKCS1_PADDING`
  bool _verify(
    List<int> publicKeyDer,
    List<int> digest,
    List<int> signature,
    HashAlgorithm hashAlg,
    _RSAPadding padding,
  ) {
    if (padding != _RSAPadding.RSA_PKCS1_PSS_PADDING &&
        padding != _RSAPadding.RSA_PKCS1_PADDING) {
      logger.log(
        "RSA.verify: Unsupported padding scheme. Supported paddings are `RSA_PKCS1_PSS_PADDING` or `RSA_PKCS1_PADDING`",
      );
      return false;
    }

    return arenaWrapper((SafeArena arena) {
          // Parse the public key
          final pubKeyBytesPtr = publicKeyDer.toUint8List().toFFIPointer(arena);
          final rsaPtr = arena.using(
            ffiBindings.RSA_public_key_from_bytes(
              pubKeyBytesPtr,
              publicKeyDer.length,
            ),
            ffiBindings.RSA_free,
          );

          if (rsaPtr == ffi.nullptr) {
            logger.log("RSA.verify: Failed to parse public key bytes");
            return false;
          }

          final digestPtr = digest.toUint8List().toFFIPointer(arena);
          final signaturePtr = signature.toUint8List().toFFIPointer(arena);

          int result;

          if (padding == _RSAPadding.RSA_PKCS1_PADDING) {
            // Legacy PKCS#1 v1.5 Verification
            result = ffiBindings.RSA_verify(
              hashAlg.envNID,
              digestPtr,
              digest.length,
              signaturePtr,
              signature.length,
              rsaPtr,
            );
          } else {
            // Modern PSS Verification
            // -1 (RSA_PSS_SALTLEN_DIGEST) means expected salt length matches the hash length
            result = ffiBindings.RSA_verify_pss_mgf1(
              rsaPtr,
              digestPtr,
              digest.length,
              hashAlg.objectPtr,
              ffi.nullptr, // mgf1_md (nullptr means use the same hash alg)
              -1, // salt_len
              signaturePtr,
              signature.length,
            );
          }

          return result == 1;
        }) ??
        false;
  }

  bool? verifySHA1DigestPKCS1(
    List<int> publicKeyDer,
    List<int> digest,
    List<int> signature,
  ) {
    return _verify(
      publicKeyDer,
      digest,
      signature,
      HashAlgorithm.sha1,
      _RSAPadding.RSA_PKCS1_PADDING,
    );
  }

  bool? verifySHA1DigestPKCS1_PSS(
    List<int> publicKeyDer,
    List<int> digest,
    List<int> signature,
  ) {
    return _verify(
      publicKeyDer,
      digest,
      signature,
      HashAlgorithm.sha1,
      _RSAPadding.RSA_PKCS1_PSS_PADDING,
    );
  }

  bool? verifySHA224DigestPKCS1(
    List<int> publicKeyDer,
    List<int> digest,
    List<int> signature,
  ) {
    return _verify(
      publicKeyDer,
      digest,
      signature,
      HashAlgorithm.sha224,
      _RSAPadding.RSA_PKCS1_PADDING,
    );
  }

  bool? verifySHA224DigestPKCS1_PSS(
    List<int> publicKeyDer,
    List<int> digest,
    List<int> signature,
  ) {
    return _verify(
      publicKeyDer,
      digest,
      signature,
      HashAlgorithm.sha224,
      _RSAPadding.RSA_PKCS1_PSS_PADDING,
    );
  }

  bool? verifySHA256DigestPKCS1(
    List<int> publicKeyDer,
    List<int> digest,
    List<int> signature,
  ) {
    return _verify(
      publicKeyDer,
      digest,
      signature,
      HashAlgorithm.sha256,
      _RSAPadding.RSA_PKCS1_PADDING,
    );
  }

  bool? verifySHA256DigestPKCS1_PSS(
    List<int> publicKeyDer,
    List<int> digest,
    List<int> signature,
  ) {
    return _verify(
      publicKeyDer,
      digest,
      signature,
      HashAlgorithm.sha256,
      _RSAPadding.RSA_PKCS1_PSS_PADDING,
    );
  }

  bool? verifySHA384DigestPKCS1(
    List<int> publicKeyDer,
    List<int> digest,
    List<int> signature,
  ) {
    return _verify(
      publicKeyDer,
      digest,
      signature,
      HashAlgorithm.sha384,
      _RSAPadding.RSA_PKCS1_PADDING,
    );
  }

  bool? verifySHA384DigestPKCS1_PSS(
    List<int> publicKeyDer,
    List<int> digest,
    List<int> signature,
  ) {
    return _verify(
      publicKeyDer,
      digest,
      signature,
      HashAlgorithm.sha384,
      _RSAPadding.RSA_PKCS1_PSS_PADDING,
    );
  }

  bool? verifySHA512DigestPKCS1(
    List<int> publicKeyDer,
    List<int> digest,
    List<int> signature,
  ) {
    return _verify(
      publicKeyDer,
      digest,
      signature,
      HashAlgorithm.sha512,
      _RSAPadding.RSA_PKCS1_PADDING,
    );
  }

  bool? verifySHA512DigestPKCS1_PSS(
    List<int> publicKeyDer,
    List<int> digest,
    List<int> signature,
  ) {
    return _verify(
      publicKeyDer,
      digest,
      signature,
      HashAlgorithm.sha512,
      _RSAPadding.RSA_PKCS1_PSS_PADDING,
    );
  }

  bool? verifySHA512_256DigestPKCS1(
    List<int> publicKeyDer,
    List<int> digest,
    List<int> signature,
  ) {
    return _verify(
      publicKeyDer,
      digest,
      signature,
      HashAlgorithm.sha512_256,
      _RSAPadding.RSA_PKCS1_PADDING,
    );
  }

  bool? verifySHA512_256DigestPKCS1_PSS(
    List<int> publicKeyDer,
    List<int> digest,
    List<int> signature,
  ) {
    return _verify(
      publicKeyDer,
      digest,
      signature,
      HashAlgorithm.sha512_256,
      _RSAPadding.RSA_PKCS1_PSS_PADDING,
    );
  }

  ffi.Pointer<bindings.BIGNUM>? _getBigNumPointer(int val, SafeArena arena) {
    final numPtr = arena.using(
      ffiBindings.BN_new(),
      ffiBindings.BN_free, // Called automatically on arena exit!
    );
    if (numPtr == ffi.nullptr) {
      return null;
    }

    final success = ffiBindings.BN_set_word(numPtr, val);
    if (success != 1) {
      return null;
    }

    return numPtr;
  }
}
