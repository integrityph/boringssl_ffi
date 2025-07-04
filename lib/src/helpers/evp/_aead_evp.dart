import 'dart:ffi' as ffi;

import 'package:boringssl_ffi/src/bindings/bindings.dart' as bindings;
import 'package:boringssl_ffi/src/ffi_lib/ffi_bindings.dart';

const _EVP_aead_aes_128_gcm = "EVP_aead_aes_128_gcm";
const _EVP_aead_aes_192_gcm = "EVP_aead_aes_192_gcm";
const _EVP_aead_aes_256_gcm = "EVP_aead_aes_256_gcm";
const _EVP_aead_chacha20_poly1305 = "EVP_aead_chacha20_poly1305";
const _EVP_aead_xchacha20_poly1305 = "EVP_aead_xchacha20_poly1305";
const _EVP_aead_aes_128_ctr_hmac_sha256 = "EVP_aead_aes_128_ctr_hmac_sha256";
const _EVP_aead_aes_256_ctr_hmac_sha256 = "EVP_aead_aes_256_ctr_hmac_sha256";
const _EVP_aead_aes_128_gcm_siv = "EVP_aead_aes_128_gcm_siv";
const _EVP_aead_aes_256_gcm_siv = "EVP_aead_aes_256_gcm_siv";
const _EVP_aead_aes_128_gcm_randnonce = "EVP_aead_aes_128_gcm_randnonce";
const _EVP_aead_aes_256_gcm_randnonce = "EVP_aead_aes_256_gcm_randnonce";
const _EVP_aead_aes_128_ccm_bluetooth = "EVP_aead_aes_128_ccm_bluetooth";
const _EVP_aead_aes_128_ccm_bluetooth_8 = "EVP_aead_aes_128_ccm_bluetooth_8";
const _EVP_aead_aes_128_ccm_matter = "EVP_aead_aes_128_ccm_matter";
const _EVP_aead_aes_128_eax = "EVP_aead_aes_128_eax";
const _EVP_aead_aes_256_eax = "EVP_aead_aes_256_eax";

enum AEADAlgorithm {
  aes_128_gcm(name: _EVP_aead_aes_128_gcm, length: 16),
  aes_192_gcm(name: _EVP_aead_aes_192_gcm, length: 24),
  aes_256_gcm(name: _EVP_aead_aes_256_gcm, length: 32),
  chacha20_poly1305(name: _EVP_aead_chacha20_poly1305, length: 32),
  xchacha20_poly1305(name: _EVP_aead_xchacha20_poly1305, length: 32),
  aes_128_ctr_hmac_sha256(name: _EVP_aead_aes_128_ctr_hmac_sha256, length: 16),
  aes_256_ctr_hmac_sha256(name: _EVP_aead_aes_256_ctr_hmac_sha256, length: 32),
  aes_128_gcm_siv(name: _EVP_aead_aes_128_gcm_siv, length: 16),
  aes_256_gcm_siv(name: _EVP_aead_aes_256_gcm_siv, length: 32),
  aes_128_gcm_randnonce(name: _EVP_aead_aes_128_gcm_randnonce, length: 16),
  aes_256_gcm_randnonce(name: _EVP_aead_aes_256_gcm_randnonce, length: 32),
  aes_128_ccm_bluetooth(name: _EVP_aead_aes_128_ccm_bluetooth, length: 16),
  aes_128_ccm_bluetooth_8(name: _EVP_aead_aes_128_ccm_bluetooth_8, length: 16),
  aes_128_ccm_matter(name: _EVP_aead_aes_128_ccm_matter, length: 16),
  aes_128_eax(name: _EVP_aead_aes_128_eax, length: 16),
  aes_256_eax(name: _EVP_aead_aes_256_eax, length: 32);

  const AEADAlgorithm({required this.name, required this.length});

  final String name;
  final int length;
  static Map<String, ffi.Pointer<bindings.EVP_AEAD>> _envCache = {};

  ffi.Pointer<bindings.EVP_AEAD> get objectPtr {
    return _envCache.putIfAbsent(name, () {
      switch (this) {
        case aes_128_gcm: return ffiBindings.EVP_aead_aes_128_gcm();
        case aes_192_gcm: return ffiBindings.EVP_aead_aes_192_gcm();
        case aes_256_gcm: return ffiBindings.EVP_aead_aes_256_gcm();
        case chacha20_poly1305: return ffiBindings.EVP_aead_chacha20_poly1305();
        case xchacha20_poly1305: return ffiBindings.EVP_aead_xchacha20_poly1305();
        case aes_128_ctr_hmac_sha256: return ffiBindings.EVP_aead_aes_128_ctr_hmac_sha256();
        case aes_256_ctr_hmac_sha256: return ffiBindings.EVP_aead_aes_256_ctr_hmac_sha256();
        case aes_128_gcm_siv: return ffiBindings.EVP_aead_aes_128_gcm_siv();
        case aes_256_gcm_siv: return ffiBindings.EVP_aead_aes_256_gcm_siv();
        case aes_128_gcm_randnonce: return ffiBindings.EVP_aead_aes_128_gcm_randnonce();
        case aes_256_gcm_randnonce: return ffiBindings.EVP_aead_aes_256_gcm_randnonce();
        case aes_128_ccm_bluetooth: return ffiBindings.EVP_aead_aes_128_ccm_bluetooth();
        case aes_128_ccm_bluetooth_8: return ffiBindings.EVP_aead_aes_128_ccm_bluetooth_8();
        case aes_128_ccm_matter: return ffiBindings.EVP_aead_aes_128_ccm_matter();
        case aes_128_eax: return ffiBindings.EVP_aead_aes_128_eax();
        case aes_256_eax: return ffiBindings.EVP_aead_aes_256_eax();
      }
    });
  }
}
