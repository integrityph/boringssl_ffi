import 'package:logging/logging.dart' as logging;
import 'package:boringssl_ffi/src/logging/logging.dart';
import '../../../../grill_testing/grill_testing.dart';
import 'seal.dart';
// import 'open_test.dart';

final List<GrillGroupFunc> testGroupList = [sealTest]; //, decryptTest];
final List<GrillGroupFunc> benchmarkGroupList = [sealBenchmark]; //, decryptBenchmark];

// void main() {
//   logging.Logger.root.level = logging.Level.ALL;
//   logging.Logger.root.onRecord.listen((record) {
//     // During tests, you might want to suppress some logs or route them differently.
//     // For now, just print non-debug logs, or route to a test-specific buffer.
//     if (record.level != logging.Level.FINEST &&
//         record.level != logging.Level.FINE) {
//       print('[LOG] ${record.level.name}: ${record.message}');
//     }
//   });

//   logger.configure(showStackTraces: true);

//   for (var groupItem in testGroupList) {
//     groupItem();
//   }
// }
