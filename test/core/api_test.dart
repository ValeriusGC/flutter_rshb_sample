import 'package:flutter_test/flutter_test.dart';
import 'package:frshbsample/core/api/remote_provider_data.dart';
import 'package:frshbsample/core/api/remote_stub_provider_impl.dart';

import 'common/common.dart';
import 'common/test_sl.dart';

Future<String> _loadFromAsset() async {
  return TheData;
}

void main() async {
  setUpAll(() async {
    setupGetIt();
    await getIt.allReady();
  });

  test('API RemoteProvider test', () async {
    print('${testDelimiter()}: API RemoteProvider  test');
    final s1 = await _loadFromAsset();
    final s2 = await TestTheRemoteProvider.fetch();
    expect(s2, equals(s1));
  });

  test('Delay test', () async {
    print('${testDelimiter()}: Delay test');

    /// test that delaying between 300 & 600 msecs
    for (var i = 0; i < 10; ++i) {
      final start = DateTime.now().millisecondsSinceEpoch;
      await TestTheRemoteProvider.fetch();
      final passed = DateTime.now().millisecondsSinceEpoch - start;
      expect(passed, lessThan(StubApiConst.upperBound));
      expect(passed, greaterThan(StubApiConst.lowerBound));
    }
  });
}
