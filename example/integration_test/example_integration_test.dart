import 'package:integration_test/integration_test.dart';
import '../../test/integration_test_entry.dart' as boringssl_ffi_tests;

void main() {
  // Initialize the integration test binding.
  // This must be called before any test group or test is defined.
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const iterations = int.fromEnvironment("iterations", defaultValue:1);

  print("iterations: $iterations");

  // Run all the tests defined in your plugin's integration_test file.
  boringssl_ffi_tests.startTesting(iterations);
}