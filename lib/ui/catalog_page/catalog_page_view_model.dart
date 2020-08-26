import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frshbsample/core/domain/product.dart';
import 'package:frshbsample/core/model/catalog_data.dart';
import 'package:frshbsample/core/model/model.dart';
import 'package:frshbsample/sl.dart';
import 'package:meta/meta.dart';
import 'package:frshbsample/ui/nav_service.dart';
import 'package:rxdart/rxdart.dart';

@immutable
class CatalogPageViewModel implements Model{

  @override
  Future init() async {
    model.onDataChanged.listen((event) {
      _onDataChanged.add(event);
      final entries = event.data.products.map((e) async {
        final path = e.image;
        final image = await _buildImage(path);
        return MapEntry(e.id, image);
      }).toList();

      Stream.fromFutures(entries).toList().then((value) {
        final map = Map.fromEntries(value);
        _onImageLoaded.add(map);
      });
    });

    model.onFavoriteChanged.listen((event) => _onFavoriteChanged.add(event));
    model.onFavoriteFilter.listen((event) => _onFavoriteFilter.add(event));
    model.onCategoriesFilter.listen((event) => _onCategoriesFilter.add(event));
    model.onAffectedData.listen((event) => _onAffectedData.add(event));
    model.onSortByPrice.listen((event) => _onSortByPrice.add(event));

    model.init();
  }


  final _onDataChanged =
  BehaviorSubject.seeded(ModelState.loading(data: CatalogData()));

  final model = TheCatalogModel;

  Stream<ModelState<CatalogData>> get onDataChanged => _onDataChanged.stream;

  ModelState<CatalogData> get value => _onDataChanged.stream.value;

  final _onFavoriteChanged = BehaviorSubject.seeded(<int>[]);

  Stream<List<int>> get onFavoriteChanged => _onFavoriteChanged.stream;

  List<int> get favorites => _onFavoriteChanged.stream.value;

  final _onImageLoaded = BehaviorSubject.seeded(<int, Image>{});

  Stream<Map<int, Image>> get onImageLoaded => _onImageLoaded.stream;

  Map<int, Image> get images => _onImageLoaded.stream.value;

  final _onFavoriteFilter = BehaviorSubject.seeded(false);

  Stream<bool> get onFavoriteFilter => _onFavoriteFilter.stream;

  bool get favoriteFilter => _onFavoriteFilter.stream.value;

  ///

  final _onCategoriesFilter = BehaviorSubject.seeded(<String>[]);

  Stream<List<String>> get onCategoriesFilter => _onCategoriesFilter.stream;

  List<String> get categoriesFilter => _onCategoriesFilter.stream.value;

  ///

  final _onSortByPrice = BehaviorSubject.seeded(false);

  Stream<bool> get onSortByPrice => _onSortByPrice.stream;

  bool get sortByPrice => _onSortByPrice.stream.value;

  ///

  final _onAffectedData = BehaviorSubject.seeded(<Product>[]);

  Stream<List<Product>> get onAffectedData => _onAffectedData.stream;

  List<Product> get affectedData => _onAffectedData.stream.value;

  Future<Image> _buildImage(String path) async {
    return rootBundle.load(path).then((value) {
      return Image.memory(
        value.buffer.asUint8List(),
      );
    }).catchError((_) {
      return Image.asset(
        'assets/images/products/photo-coming-soon.jpg',
      );
    });
  }


  Future markFavorite(int index, bool mark) async {
    model.markFavorite(index, mark);
  }

  Future filterFavorite(bool on) async {
    model.filterFavorite(on);
  }

  Future filterByCategory(String category, bool on) async {
    model.filterByCategory(category, on);
  }

  Future doSortByPrice(bool on) async {
    model.doSortByPrice(on);
  }

  Future loadDetail(Product product) async {
    navService.pushNamed(NavConst.detailRoute);
  }

  @override
  Future dispose() async {
    _onDataChanged.close();
    _onFavoriteChanged.close();
    _onImageLoaded.close();
    _onFavoriteFilter.close();
    _onAffectedData.close();
  }

}
