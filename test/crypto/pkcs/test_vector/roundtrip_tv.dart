const testVectorsStr = """
{
  "keySizesBits": [512, 1024, 2048, 3072, 4096],
  "fips": [false, true],
  "hashes": [
    { "name": "SHA-1", "bytes": 20 },
    { "name": "SHA-224", "bytes": 28 },
    { "name": "SHA-256", "bytes": 32 },
    { "name": "SHA-384", "bytes": 48 },
    { "name": "SHA-512", "bytes": 64 },
    { "name": "SHA-512_256", "bytes": 32 }
  ],
  "cipherPaddings": ["NO_PADDING", "PKCS1", "PKCS1_OAEP"],
  "sigPaddings": ["PKCS1", "PKCS1_PSS"]
}
""";