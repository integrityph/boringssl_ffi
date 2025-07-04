import 'dart:typed_data';

import 'package:boringssl_ffi/src/logging/logging.dart';

/// Pads the input [data] using PKCS#7 padding scheme to be a multiple of [blockSize].
///
/// PKCS#7 padding always adds padding bytes. If the data is already a multiple
/// of the [blockSize], a full block of padding is added. Each padding byte's
/// value is equal to the number of padding bytes added.
///
/// - [data]: The input data to be padded.
/// - [blockSize]: The block size of the cipher, in bytes (e.g., 16 for AES).
///                Must be between 1 and 255 inclusive.
///
/// Returns: A new [Uint8List] containing the padded data.
///
/// Throws [ArgumentError] if [blockSize] is invalid.
Uint8List? padPKCS7(List<int> data, int blockSize) {
  if (blockSize <= 0 || blockSize > 255) {
    logger.log('blockSize must be between 1 and 255 for PKCS#7 padding.');
    return null;
  }

  final int paddingLength = blockSize - (data.length % blockSize);
  // If data.length % blockSize is 0, paddingLength will be blockSize.
  // This correctly handles the case where data is already a multiple of blockSize,
  // requiring a full block of padding.

  final Uint8List paddedData = Uint8List(data.length + paddingLength);

  // Copy the original data
  paddedData.setAll(0, data);

  // Fill the padding bytes
  for (int i = 0; i < paddingLength; i++) {
    paddedData[data.length + i] = paddingLength;
  }

  return paddedData;
}

Uint8List? unpadPKCS7(List<int> paddedData, int blockSize) {
  if (blockSize <= 0 || blockSize > 255) {
    logger.log('blockSize must be between 1 and 255 for PKCS#7 unpadding.');
    return null;
  }

  if (paddedData.isEmpty) {
    // An empty padded data can't contain valid padding information.
    // PKCS#7 requires at least one byte of padding.
    logger.log('Padded data cannot be empty for PKCS#7 unpadding.');
    return null;
  }

  if (paddedData.length % blockSize != 0) {
    // Padded data length must be a multiple of blockSize.
    logger.log('Padded data length (${paddedData.length}) is not a multiple of blockSize ($blockSize). Invalid padding.');
    return null;
  }

  // Get the last byte, which indicates the padding length.
  final int paddingLength = paddedData.last;

  // Validate the padding length.
  // It must be greater than 0 and less than or equal to blockSize.
  if (paddingLength <= 0 || paddingLength > blockSize) {
    logger.log('Invalid PKCS#7 padding length ($paddingLength) found. It must be > 0 and <= blockSize ($blockSize).');
    return null;
  }

  // Calculate the expected start of padding.
  final int expectedPaddingStart = paddedData.length - paddingLength;

  // Verify all padding bytes are correct.
  // Iterate from the start of the padding to the end of the data.
  for (int i = expectedPaddingStart; i < paddedData.length; i++) {
    if (paddedData[i] != paddingLength) {
      logger.log('PKCS#7 padding verification failed: byte at index $i was ${paddedData[i]}, expected $paddingLength.');
      return null; // Padding bytes are not uniform
    }
  }

  // Extract the original data by slicing off the padding.
  // Using List.sublist for List<int> or Uint8List.sublist for Uint8List
  return Uint8List.fromList(paddedData.sublist(0, expectedPaddingStart));
}