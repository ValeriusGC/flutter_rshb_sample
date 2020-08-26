import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'common/common.dart';
import 'common/test_sl.dart';

void main() async {
  EquatableConfig.stringify = true;

  group(('TheLocalStorage'), () {
    setUpAll(() async {
      setupGetIt();
      await getIt.allReady();
    });

    test('TheLocalStorage init test', () async {
      print('${testDelimiter()}: TheLocalStorage init test');
      final storage = TestTheLocalStorage;
      expect(storage, isNotNull);
    });

    test('LocalStorage put favorites test', () async {
      print('${testDelimiter()}: LocalStorage put favorites test');
      final storage = TestTheLocalStorage;
      final empty = await storage.getFavoritesIndices();
      expect(empty, equals([]));
      //
      final fav = [2, 3, 14];
      await storage.putFavoritesIndices(fav);
      final back = await storage.getFavoritesIndices();
      expect(back, equals(fav));
    });
  });
}
