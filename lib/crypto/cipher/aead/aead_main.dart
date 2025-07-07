import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:boringssl_ffi/src/bindings/bindings.dart' as bindings;
import 'package:boringssl_ffi/src/ffi_lib/ffi_lib.dart';
import 'package:boringssl_ffi/src/helpers/collections/first_where_nullable.dart';
import 'package:boringssl_ffi/src/helpers/conversion/list_to_bytearray.dart';
import 'package:boringssl_ffi/src/helpers/evp/aead_evp.dart';
import 'package:boringssl_ffi/src/logging/logging.dart';

part 'aead_session.dart';

const aead = AEAD();

class AEAD {
  const AEAD();

  static const Map<String, List<AEADAlgorithm>> _algoMap = {
    "AES_GCM": [
      AEADAlgorithm.aes_128_gcm,
      AEADAlgorithm.aes_192_gcm,
      AEADAlgorithm.aes_256_gcm,
    ],
    "ChaCha20Poly1305": [AEADAlgorithm.chacha20_poly1305],
    "XChaCha20Poly1305": [AEADAlgorithm.xchacha20_poly1305],
    "AES_CTR_HMAC_SHA256": [
      AEADAlgorithm.aes_128_ctr_hmac_sha256,
      AEADAlgorithm.aes_256_ctr_hmac_sha256,
    ],
    "AES_GCM_SIV": [
      AEADAlgorithm.aes_128_gcm_siv,
      AEADAlgorithm.aes_256_gcm_siv,
    ],
    "AES_GCM_RandNonce": [
      AEADAlgorithm.aes_128_gcm_randnonce,
      AEADAlgorithm.aes_256_gcm_randnonce,
    ],
    "AES_CCM_Bluetooth": [AEADAlgorithm.aes_128_ccm_bluetooth],
    "AES_CCM_Bluetooth8": [AEADAlgorithm.aes_128_ccm_bluetooth_8],
    "AES_CCM_Matter": [AEADAlgorithm.aes_128_ccm_matter],
    "AES_EAX": [AEADAlgorithm.aes_128_eax, AEADAlgorithm.aes_256_eax],
  };

  AEADSession? initSessionAES_GCM(List<int> key) {
    return _initSessionNamed("AES_GCM", key);
  }

  AEADSession? initSessionChaCha20Poly1305(List<int> key) {
    return _initSessionNamed("ChaCha20Poly1305", key);
  }

  AEADSession? initSessionXChaCha20Poly1305(List<int> key) {
    return _initSessionNamed("XChaCha20Poly1305", key);
  }

  AEADSession? initSessionAES_CTR_HMAC_SHA256(List<int> key) {
    return _initSessionNamed("AES_CTR_HMAC_SHA256", key);
  }

  AEADSession? initSessionAES_GCM_SIV(List<int> key) {
    return _initSessionNamed("AES_GCM_SIV", key);
  }

  AEADSession? initSessionAES_GCM_RandNonce(List<int> key) {
    return _initSessionNamed("AES_GCM_RandNonce", key);
  }

  AEADSession? initSessionAES_CCM_Bluetooth(List<int> key) {
    return _initSessionNamed("AES_CCM_Bluetooth", key);
  }

  AEADSession? initSessionAES_CCM_Bluetooth8(List<int> key) {
    return _initSessionNamed("AES_CCM_Bluetooth8", key);
  }

  AEADSession? initSessionAES_CCM_Matter(List<int> key) {
    return _initSessionNamed("AES_CCM_Matter", key);
  }

  AEADSession? initSessionAES_EAX(List<int> key) {
    return _initSessionNamed("AES_EAX", key);
  }

  AEADSession? _initSessionNamed(String algoGroupName, List<int> key) {
    final algoList = _algoMap[algoGroupName]!;
    final AEADAlgorithm? aeadAlgorithm = algoList.firstWhereOrNull(
      (algo) => algo.keyLength == key.length,
    );

    if (aeadAlgorithm == null) {
      logger.log(
        "AEAD.initSession$algoGroupName: `${key.length}` is an invalid key length. Valid values: ${algoList.map<String>((algo) => "${algo.keyLength}").join(", ")}",
      );
      return null;
    }

    return _initSession(key.toUint8List(), aeadAlgorithm);
  }

  AEADSession? _initSession(
    Uint8List key,
    AEADAlgorithm aeadAlgorithm, {
    int? tagLength,
  }) {
    return AEADSession.initSession(key, aeadAlgorithm, tagLength: tagLength);
  }

  Uint8List? sealAES_GCM(
    List<int> data,
    List<int> additionalData,
    List<int> key,
    List<int> nonce,
  ) {
    return _sealNamed("AES_GCM", data, additionalData, key, nonce);
  }

  Uint8List? sealChaCha20Poly1305(
    List<int> data,
    List<int> additionalData,
    List<int> key,
    List<int> nonce,
  ) {
    return _sealNamed("ChaCha20Poly1305", data, additionalData, key, nonce);
  }

  Uint8List? sealXChaCha20Poly1305(
    List<int> data,
    List<int> additionalData,
    List<int> key,
    List<int> nonce,
  ) {
    return _sealNamed("XChaCha20Poly1305", data, additionalData, key, nonce);
  }

  Uint8List? sealAES_CTR_HMAC_SHA256(
    List<int> data,
    List<int> additionalData,
    List<int> key,
    List<int> nonce,
  ) {
    return _sealNamed("AES_CTR_HMAC_SHA256", data, additionalData, key, nonce);
  }

  Uint8List? sealAES_GCM_SIV(
    List<int> data,
    List<int> additionalData,
    List<int> key,
    List<int> nonce,
  ) {
    return _sealNamed("AES_GCM_SIV", data, additionalData, key, nonce);
  }

  Uint8List? sealAES_GCM_RandNonce(
    List<int> data,
    List<int> additionalData,
    List<int> key,
    List<int> nonce,
  ) {
    return _sealNamed("AES_GCM_RandNonce", data, additionalData, key, nonce);
  }

  Uint8List? sealAES_CCM_Bluetooth(
    List<int> data,
    List<int> additionalData,
    List<int> key,
    List<int> nonce,
  ) {
    return _sealNamed("AES_CCM_Bluetooth", data, additionalData, key, nonce);
  }

  Uint8List? sealAES_CCM_Bluetooth8(
    List<int> data,
    List<int> additionalData,
    List<int> key,
    List<int> nonce,
  ) {
    return _sealNamed("AES_CCM_Bluetooth8", data, additionalData, key, nonce);
  }

  Uint8List? sealAES_CCM_Matter(
    List<int> data,
    List<int> additionalData,
    List<int> key,
    List<int> nonce,
  ) {
    return _sealNamed("AES_CCM_Matter", data, additionalData, key, nonce);
  }

  Uint8List? sealAES_EAX(
    List<int> data,
    List<int> additionalData,
    List<int> key,
    List<int> nonce,
  ) {
    return _sealNamed("AES_EAX", data, additionalData, key, nonce);
  }

  Uint8List? _sealNamed(
    String algoGroupName,
    List<int> data,
    List<int> additionalData,
    List<int> key,
    List<int> nonce,
  ) {
    final algoList = _algoMap[algoGroupName]!;
    final AEADAlgorithm? aeadAlgorithm = algoList.firstWhereOrNull(
      (algo) => algo.keyLength == key.length,
    );

    if (aeadAlgorithm == null) {
      logger.log(
        "AEAD.seal$algoGroupName: `${key.length}` is an invalid key length. Valid values: ${algoList.map<String>((algo) => "${algo.keyLength}").join(", ")}",
      );
      return null;
    }

    return _sealOneShot(
      data.toUint8List(),
      additionalData.toUint8List(),
      key.toUint8List(),
      nonce.toUint8List(),
      aeadAlgorithm,
    );
  }

  Uint8List? _sealOneShot(
    Uint8List data,
    Uint8List additionalData,
    Uint8List key,
    Uint8List nonce,
    AEADAlgorithm aeadAlgorithm, {
    int? tagLength,
  }) {
    final session = AEADSession.initSession(
      key,
      aeadAlgorithm,
      tagLength: tagLength,
    );
    if (session == null) {
      return null;
    }
    final result = session.seal(data, additionalData, nonce);
    session.destroy();
    return result;
  }

  Uint8List? openAES_GCM(
    List<int> data,
    List<int> additionalData,
    List<int> key,
    List<int> nonce,
  ) {
    return _openNamed("AES_GCM", data, additionalData, key, nonce);
  }

  Uint8List? openChaCha20Poly1305(
    List<int> data,
    List<int> additionalData,
    List<int> key,
    List<int> nonce, {
    int? tagLength,
  }) {
    return _openNamed(
      "ChaCha20Poly1305",
      data,
      additionalData,
      key,
      nonce,
      tagLength: tagLength,
    );
  }

  Uint8List? openXChaCha20Poly1305(
    List<int> data,
    List<int> additionalData,
    List<int> key,
    List<int> nonce, {
    int? tagLength,
  }) {
    return _openNamed(
      "XChaCha20Poly1305",
      data,
      additionalData,
      key,
      nonce,
      tagLength: tagLength,
    );
  }

  Uint8List? openAES_CTR_HMAC_SHA256(
    List<int> data,
    List<int> additionalData,
    List<int> key,
    List<int> nonce,
  ) {
    return _openNamed("AES_CTR_HMAC_SHA256", data, additionalData, key, nonce);
  }

  Uint8List? openAES_GCM_SIV(
    List<int> data,
    List<int> additionalData,
    List<int> key,
    List<int> nonce,
  ) {
    return _openNamed("AES_GCM_SIV", data, additionalData, key, nonce);
  }

  Uint8List? openAES_GCM_RandNonce(
    List<int> data,
    List<int> additionalData,
    List<int> key,
    List<int> nonce,
  ) {
    return _openNamed("AES_GCM_RandNonce", data, additionalData, key, nonce);
  }

  Uint8List? openAES_CCM_Bluetooth(
    List<int> data,
    List<int> additionalData,
    List<int> key,
    List<int> nonce,
  ) {
    return _openNamed("AES_CCM_Bluetooth", data, additionalData, key, nonce);
  }

  Uint8List? openAES_CCM_Bluetooth8(
    List<int> data,
    List<int> additionalData,
    List<int> key,
    List<int> nonce,
  ) {
    return _openNamed("AES_CCM_Bluetooth8", data, additionalData, key, nonce);
  }

  Uint8List? openAES_CCM_Matter(
    List<int> data,
    List<int> additionalData,
    List<int> key,
    List<int> nonce,
  ) {
    return _openNamed("AES_CCM_Matter", data, additionalData, key, nonce);
  }

  Uint8List? openAES_EAX(
    List<int> data,
    List<int> additionalData,
    List<int> key,
    List<int> nonce,
  ) {
    return _openNamed("AES_EAX", data, additionalData, key, nonce);
  }

  Uint8List? _openNamed(
    String algoGroupName,
    List<int> data,
    List<int> additionalData,
    List<int> key,
    List<int> nonce, {
    int? tagLength,
  }) {
    final algoList = _algoMap[algoGroupName]!;
    final AEADAlgorithm? aeadAlgorithm = algoList.firstWhereOrNull(
      (algo) => algo.keyLength == key.length,
    );

    if (aeadAlgorithm == null) {
      logger.log(
        "AEAD.open$algoGroupName: `${key.length}` is an invalid key length. Valid values: ${algoList.map<String>((algo) => "${algo.keyLength}").join(", ")}",
      );
      return null;
    }

    return _openOneShot(
      data.toUint8List(),
      additionalData.toUint8List(),
      key.toUint8List(),
      nonce.toUint8List(),
      aeadAlgorithm,
      tagLength: tagLength,
    );
  }

  Uint8List? _openOneShot(
    Uint8List data,
    Uint8List additionalData,
    Uint8List key,
    Uint8List nonce,
    AEADAlgorithm aeadAlgorithm, {
    int? tagLength,
  }) {
    final session = AEADSession.initSession(
      key,
      aeadAlgorithm,
      tagLength: tagLength,
    );
    if (session == null) {
      return null;
    }
    final result = session.open(data, additionalData, nonce);
    session.destroy();
    return result;
  }
}
