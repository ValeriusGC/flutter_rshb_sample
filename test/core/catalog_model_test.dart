import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';

import 'common/common.dart';
import 'common/test_sl.dart';


///
void main() async {
  EquatableConfig.stringify = true;

  setUpAll(() async {
    setupGetIt();
    await getIt.allReady();
  });

  test('CatalogModel test', () async {
    print('${testDelimiter()}: CatalogModel test');
    final model = TestTheCatalogModel;
//    model.onDataChanged.listen((event) {
////      print('model.onDataChanged.listen(${event.data})');
//    });
    await model.init();
    expect(model.value.data.sections.length, equals(3));
    expect(model.value.data.farmers.length, equals(3));
    expect(model.value.data.categories.length, equals(3));
    expect(model.value.data.products.length, equals(9));
  });

  test('CatalogModel load/clear test', () async {
    print('${testDelimiter()}: CatalogModel load/clear test');
    final model = TestTheCatalogModel;
    model.onDataChanged.listen((event) {
//      print('model.onDataChanged.listen($event)');
    });
    await model.clear();
    expect(model.value.data.sections.length, equals(0));
    expect(model.value.data.farmers.length, equals(0));
    expect(model.value.data.categories.length, equals(0));
    expect(model.value.data.products.length, equals(0));
    //
    await model.load();
    expect(model.value.data.sections.length, equals(3));
    expect(model.value.data.farmers.length, equals(3));
    expect(model.value.data.categories.length, equals(3));
    expect(model.value.data.products.length, equals(9));
    //
    await model.load();
    expect(model.value.data.sections.length, equals(3));
    expect(model.value.data.farmers.length, equals(3));
    expect(model.value.data.categories.length, equals(3));
    expect(model.value.data.products.length, equals(9));
  });

  test('Favorite items test', () async {
    print('${testDelimiter()}: Favorite items test');
    final model = TestTheCatalogModel;
    await model.init();
    //
    await model.clearFavorites();
    expect(model.favourite.length, equals(0));
    await model.markFavorite(2, true);
    expect(model.favourite.length, equals(1));
    expect(model.favourite.contains(2), isTrue);
    await model.markFavorite(2, true);
    expect(model.favourite.length, equals(1));
    expect(model.favourite.contains(2), isTrue);
    await model.markFavorite(1, true);
    expect(model.favourite.length, equals(2));
    expect(model.favourite, equals([1,2]));
    await model.markFavorite(1, false);
    expect(model.favourite, equals([2]));
    await model.markFavorite(1, false);
    expect(model.favourite, equals([2]));
    await model.markFavorite(3, false);
    expect(model.favourite, equals([2]));
    await model.markFavorite(2, false);
    expect(model.favourite, equals([]));
  });



  test('LocalStorage put favorites test', () async {
    print('${testDelimiter()}: LocalStorage put favorites test');
    final storage = TestTheLocalStorage;
    final empty = await storage.getFavoritesIndices();
    expect(empty, equals([]));
    final fav = [2, 3, 14];
    await storage.putFavoritesIndices(fav);
    final back = await storage.getFavoritesIndices();
    expect(back, equals(fav));
  });

}
