import '../../make_test/make_test_func.dart';

import 'test_vector/kyber_tv.dart' as kyber_tv;

import 'tests/kyber_encap_decap.dart' as kyber_encap_decap;


final testList = [
  makeTest(
    "Kyber Encapsulate Decapsulate",
    kyber_tv.testVectorsStr,
    kyber_encap_decap.testFunc,
    keyValueSeparator: "=",
  ),
];
