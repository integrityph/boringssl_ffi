// In boringssl_ffi/example/lib/main.dart
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';

// Import our plugin's main file.
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

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // A simple method to call our plugin and update the UI.
  Future<void> initPlatformState() async {
    String version;
    String sha256;
    try {
      version = BoringSslFFI.getVersion();
      sha256 = BoringSslFFI.hex_encode(BoringSslFFI.SHA256([1,2,3])??[]);
    } catch (e) {
      version = 'Failed to get version: ${e.toString()}';
      sha256 = 'Failed to get SHA256: ${e.toString()}';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _boringSslVersion = version;
      _boringSslsha256 = sha256;
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
            ],
          ),
        ),
      ),
    );
  }
}