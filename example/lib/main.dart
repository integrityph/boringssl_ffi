import 'package:boringssl_ffi_example/benchmarks/sha256/sha256.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:boringssl_ffi/boringssl_ffi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _boringSslVersion = 'Unknown';
  String _boringSslsha256 = 'Unknown';
  String _boringSslsha256Benchmark = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // A simple method to call our plugin and update the UI.
  Future<void> initPlatformState() async {
    String versionVal;
    String sha256Val;
    try {
      versionVal = "XXX";
      sha256Val = hex.encode(sha256.hash([1,2,3])??[]);
    } catch (e) {
      versionVal = 'Failed to get version: ${e.toString()}';
      sha256Val = 'Failed to get SHA256: ${e.toString()}';
    }

    if (!mounted) return;

    setState(() {
      _boringSslVersion = versionVal;
      _boringSslsha256 = sha256Val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FFI Plugin Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'BoringSSL Version String:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                _boringSslVersion,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const Text(
                'BoringSSL SHA256([1,2,3]):',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                _boringSslsha256,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              OutlinedButton(onPressed: ()async {
                final v = await benchmarkSHA256(1_000_000);
                setState(() {
                  _boringSslsha256Benchmark = "${v.toStringAsFixed(2)} µs";
                });
              }, child: Text("Benchmark")),
              Row(children:[Text("Benchmark (1M):"), Text(_boringSslsha256Benchmark)]),
            ],
          ),
        ),
      ),
    );
  }
}