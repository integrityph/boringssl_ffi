part of 'rsa.dart';

enum _RSAPadding {
  RSA_PKCS1_PADDING(1),
  RSA_NO_PADDING(3),
  RSA_PKCS1_OAEP_PADDING(4),
  RSA_PKCS1_PSS_PADDING(6);

  final int value;

  const _RSAPadding(this.value);
}