part of 'chacha20.dart';

class ChaCha20Session {
  final List<int> _key;
  final List<int> _nonce;
  int _counter;
  ChaCha20Session(this._key, this._nonce, this._counter);

  void reset() {
    _counter = 0;
  }

  Uint8List? encrypt(List<int> data) {
    final output = chacha20._encrypt(data, _key, _nonce, _counter);
    if (output != null) {
      final double increment = data.length / ChaCha20.BLOCK_SIZE;
      _counter += increment.ceil();
    }
    return output;
  }

  Uint8List? decrypt(List<int> data) {
    final output = chacha20.decrypt(data, _key, _nonce, _counter);
    if (output != null) {
      final double increment = data.length / ChaCha20.BLOCK_SIZE;
      _counter += increment.ceil();
    }
    return output;
  }
}
