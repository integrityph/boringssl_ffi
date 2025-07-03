import 'dart:convert';

import 'package:boringssl_ffi/boringssl_ffi.dart' as boringssl_ffi;
import 'package:boringssl_ffi_example/benchmarks/run_benchmark.dart';

Future<double> benchmarkSHA256(int iterations) async {
  // load the test vector data
  final String jsonString = testVectorsStr;

  List<Map<String, dynamic>> testVectors =
      (json.decode(jsonString) as List<dynamic>)
          .map<Map<String, dynamic>>((item) => item as Map<String, dynamic>)
          .toList();

  List<double> times = [];

  // Test vector 1: Empty string
  for (final testVector in testVectors) {
    final input = (testVector['input'] as String).codeUnits;
    final v = await runBenchmark(testVector['name'], (){boringssl_ffi.sha256.hash(input);}, iterations);
    times.add(v);
  }
  final double sumMs = times.reduce((a, b) => a + b);
  final double avgMs = times.isEmpty ? 0.0 : sumMs / times.length;
  return avgMs;
}

const testVectorsStr = """
[
	{
		"name":"should correctly hash an empty string",
		"input":"",
		"output":"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
		"shouldPass":true
	},
  {
		"name":"should correctly hash abc",
		"input":"abc",
		"output":"ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad",
		"shouldPass":true
	},
  {
		"name":"should correctly hash a longer alphanumeric string",
		"input":"abcdefghijklmnopqrstuvwxyz",
		"output":"71c480df93d6ae2f1efad1447c66c9525e316218cf51fc8d9ed832f2daf18b73",
		"shouldPass":true
	}
]
""";
