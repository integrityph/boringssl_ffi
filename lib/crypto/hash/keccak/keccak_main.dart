import 'keccak_sha3_256.dart' as keccak_sha3_256;

const keccak = Keccak();

class Keccak {
  const Keccak();

  keccak_sha3_256.Keccak256 get keccak256 {
    return keccak_sha3_256.keccak256;
  }
}