import 'dart:math';
import 'package:frshbsample/core/common/funcs.dart';

import 'remote_provider.dart';
import 'remote_provider_data.dart';

/// Constants for stub API
abstract class StubApiConst {
  /// Lower delay bound.
  static const lowerBound = 300;
  /// Upper delay bound.
  static const upperBound = 600;
}

/// Stub Implementation for API
class RemoteStubProviderImpl implements RemoteProvider {
  Future<String> fetch() async {
    final start = DateTime.now().millisecondsSinceEpoch;
    final s = await _loadFromAsset();
    final passed = DateTime.now().millisecondsSinceEpoch - start;
    final time = _next(StubApiConst.lowerBound, StubApiConst.upperBound - passed);
    await Future.delayed(Duration(milliseconds: time));
    return s;
  }
}

/// Randomizer for delay emulation.
final _random = new Random();

/// Next time slot for delay emulation.
int _next(int min, int max) => min + _random.nextInt(max - min);

/// Loading emulation.
Future<String> _loadFromAsset() async {
  return TheData;
}
