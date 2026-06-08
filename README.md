# BoringSSL FFI

A high-performance, idiomatically crafted Dart FFI wrapper for Google's BoringSSL.

This package brings the raw speed and battle-tested security of BoringSSL to Dart and Flutter applications. It is designed with a deeply curated, discoverable API that prioritizes developer ergonomics and compile-time safety.

## Why BoringSSL FFI instead of pure Dart cryptography?

Dart's native `package:crypto` and `pointycastle` are fantastic, but because they are written in pure Dart, they execute on the Dart VM or compile to JavaScript. 

**BoringSSL FFI binds directly to native C/Assembly code.** This provides massive advantages:
* **Blazing Fast:** Heavy cryptographic operations execute orders of magnitude faster. 
* **UI-Thread Friendly:** Operations like PBKDF2 or heavy AES-GCM encryption that would normally cause frame drops in pure Dart can often be run synchronously on the main thread without stuttering.
* **Standardized:** BoringSSL is Google's fork of OpenSSL, used in Google Chrome, Android, and countless enterprise systems.

## The API Philosophy

Cryptography APIs are notoriously difficult to navigate. This package uses a strictly typed, hierarchical namespace designed for your IDE's IntelliSense. 

Instead of passing stringly-typed algorithm names into generic functions, you simply type `bssl.` and let the IDE guide you to exactly what you need.

## Getting Started

Add the package to your `pubspec.yaml`:
```yaml
dependencies:
  boringssl_ffi: ^1.0.0
```

## Cookbook

### 1. Hashing (SHA-256)

```dart
import 'package:boringssl_ffi/boringssl_ffi.dart';

final data = utf8.encode('my secret data');

// Clean, predictable API path
final hash = bssl.sha256.hash(data);

print(bssl.hex.encode(hash));
```

### 2. Key Derivation (PBKDF2)

```dart
import 'package:boringssl_ffi/boringssl_ffi.dart';

final password = utf8.encode('password123');
final salt = utf8.encode('random_salt');

// Derive a 32-byte key using SHA-512 with 100,000 iterations
final derivedKey = bssl.pbkdf2HMAC.deriveKeySHA512(
  password: password, 
  salt: salt, 
  iterations: 100000, 
  keyLength: 32,
);
```

### 3. Authenticated Encryption (AES-GCM)

```dart
import 'package:boringssl_ffi/boringssl_ffi.dart';

final plaintext = utf8.encode('Transfer $100');
final rand = Random.secure();
final key = List.generate(32, (_)=>rand.nextInt(256)); // 256-bit key
final nonce = List.generate(12, (_)=>rand.nextInt(256));
final additionalData = utf8.encode('header_info');

// Encrypt
final ciphertext = bssl.aead.sealAES_GCM(
  plaintext: plaintext,
  additionalData: additionalData,
  key: key,
  nonce: nonce,
);

// Decrypt
final decrypted = bssl.aead.openAES_GCM(
  ciphertext: ciphertext,
  additionalData: additionalData,
  key: key,
  nonce: nonce,
);
```

### 4. HMAC

```dart
import 'package:boringssl_ffi/boringssl_ffi.dart';

final key = utf8.encode('shared_secret');
final message = utf8.encode('verify me');

final mac = bssl.hmac.hmacSHA512(key: key, data: message);
```

## Performance & Isolates

Because this package uses FFI, the cryptographic math executes outside the Dart VM. For the vast majority of use cases, you can call these functions synchronously on the main thread.

However, if you are hashing multi-gigabyte files or running extreme iteration counts for KDFs, you should still wrap the call in Isolate.run() to keep your Flutter UI perfectly smooth.

## Security Concerns

For security reports, submit a private security advisory:

https://github.com/integrityph/boringssl_ffi/security/advisories/new