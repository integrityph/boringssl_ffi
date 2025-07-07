part of 'aead_main.dart';

class AEADSession {
  final AEADAlgorithm _aeadAlgorithm;
  late final ffi.Pointer<bindings.EVP_AEAD_CTX> _contextPtr;

  AEADSession._(this._aeadAlgorithm);

  static AEADSession? initSession(Uint8List key, AEADAlgorithm aeadAlgorithm, {int? tagLength}) {
    if (key.length != aeadAlgorithm.keyLength) {
      logger.log(
        'AEADSession.initSession: Invalid key length for ${aeadAlgorithm.name}. Expected ${aeadAlgorithm.keyLength}, but got ${key.length}',
      );
      return null;
    }
    final instance = AEADSession._(aeadAlgorithm);
    arenaWrapper((arena) {
      final keyPtr = key.toFFIPointer(arena);
      instance._contextPtr = ffiBindings.EVP_AEAD_CTX_new(
        aeadAlgorithm.objectPtr,
        keyPtr,
        aeadAlgorithm.keyLength,
        tagLength??0,
      );
    });

    if (instance._contextPtr == ffi.nullptr) {
      return null;
    }

    _finalizer.attach(instance._aeadAlgorithm, instance, detach: instance._aeadAlgorithm);

    return instance;
  }

  Uint8List? seal(List<int> data, List<int> additionalData, List<int> nonce) {
    return _seal(
      data.toUint8List(),
      additionalData.toUint8List(),
      nonce.toUint8List(),
    );
  }

  Uint8List? _seal(Uint8List data, Uint8List additionalData, Uint8List nonce) {
    return arenaWrapper((arena) {
      final maxOut = _aeadAlgorithm.maxOverhead + data.length;
      final outPtr = arena.allocate<ffi.Uint8>(maxOut, isSensitive: false);
      final outLengthPrt = arena.allocate<ffi.Size>(ffi.sizeOf<ffi.Size>());
      final dataPtr = data.toFFIPointer(arena);
      final additionalDataPtr = additionalData.toFFIPointer(arena);
      final noncePtr = nonce.toFFIPointer(arena);
      final result = ffiBindings.EVP_AEAD_CTX_seal(
        _contextPtr,
        outPtr,
        outLengthPrt,
        maxOut,
        noncePtr,
        nonce.length,
        dataPtr,
        data.length,
        additionalDataPtr,
        additionalData.length,
      );
      if (result == 1) {
        return returnUint8List(outPtr, outLengthPrt.value);
      }
      logger.log(
        "AEADSession._seal: EVP_AEAD_CTX_seal failed and return a result of 0 for algorithm ${_aeadAlgorithm.name}",
      );
      return null;
    });
  }

  Uint8List? open(List<int> data, List<int> additionalData, List<int> nonce) {
    return _open(
      data.toUint8List(),
      additionalData.toUint8List(),
      nonce.toUint8List(),
    );
  }

  Uint8List? _open(Uint8List data, Uint8List additionalData, Uint8List nonce) {
    return arenaWrapper((arena) {
      final maxOut = _aeadAlgorithm.maxOverhead + data.length;
      final outPtr = arena.allocate<ffi.Uint8>(maxOut, isSensitive: false);
      final outLengthPrt = arena.allocate<ffi.Size>(ffi.sizeOf<ffi.Size>());
      final dataPtr = data.toFFIPointer(arena);
      final additionalDataPtr = additionalData.toFFIPointer(arena);
      final noncePtr = nonce.toFFIPointer(arena);
      final result = ffiBindings.EVP_AEAD_CTX_open(
        _contextPtr,
        outPtr,
        outLengthPrt,
        maxOut,
        noncePtr,
        nonce.length,
        dataPtr,
        data.length,
        additionalDataPtr,
        additionalData.length,
      );
      if (result == 1) {
        return returnUint8List(outPtr, outLengthPrt.value);
      }
      logger.log(
        "AEADSession._open: EVP_AEAD_CTX_open failed and return a result of 0 for algorithm ${_aeadAlgorithm.name}",
      );
      return null;
    });
  }

  void destroy() {
    ffiBindings.EVP_AEAD_CTX_free(_contextPtr);
    _finalizer.detach(_aeadAlgorithm);
  }

  static final Finalizer<AEADSession> _finalizer = Finalizer(
    (instance) => instance.destroy(),
  );
}
