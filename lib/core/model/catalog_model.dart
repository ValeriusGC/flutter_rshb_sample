import 'dart:convert';
import 'package:frshbsample/core/api/remote_provider.dart';
import 'package:frshbsample/core/common/funcs.dart';
import 'package:frshbsample/core/domain/category.dart';
import 'package:frshbsample/core/domain/farmer.dart';
import 'package:frshbsample/core/domain/product.dart';
import 'package:frshbsample/core/domain/section.dart';
import 'package:frshbsample/sl.dart';
import 'package:rxdart/rxdart.dart';

import 'catalog_data.dart';
import 'model.dart';

///
class CatalogModel implements Model{
  // --

  ///
  final _onDataChanged = BehaviorSubject.seeded(
    ModelState.loading(
      data: CatalogData(),
    ),
  );

  ///
  Stream<ModelState<CatalogData>> get onDataChanged => _onDataChanged.stream;

  ModelState<CatalogData> get value => _onDataChanged.stream.value;

  // --

  final _onFavouriteChanged = BehaviorSubject.seeded(<int>[]);

  Stream<List<int>> get onFavoriteChanged => _onFavouriteChanged.stream;

  List<int> get favourite => _onFavouriteChanged.stream.value;

  ///

  final _onCategoriesFilter = BehaviorSubject.seeded(<String>[]);

  Stream<List<String>> get onCategoriesFilter => _onCategoriesFilter.stream;

  List<String> get categoriesFilter => _onCategoriesFilter.stream.value;

  final _onFavoriteFilter = BehaviorSubject.seeded(false);

  Stream<bool> get onFavoriteFilter => _onFavoriteFilter.stream;

  bool get favoriteFilter => _onFavoriteFilter.stream.value;

  final _onSortByPrice = BehaviorSubject.seeded(false);

  Stream<bool> get onSortByPrice => _onSortByPrice.stream;

  bool get sortByPrice => _onSortByPrice.stream.value;

  final _onAffectedData = BehaviorSubject.seeded(<Product>[]);

  Stream<List<Product>> get onAffectedData => _onAffectedData.stream;

  List<Product> get affectedData => _onAffectedData.stream.value;

  @override
  Future init() async {
    await load();
  }

  /// Clears [CatalogData] for new loading
  Future clear() async {
    final newData = CatalogData();
    _onDataChanged.add(ModelState.success(data: newData));
  }

  ///
  Future load() async {
    await clear();
    _onDataChanged.add(ModelState.loading(data: CatalogData()));
    final json = await TheRemoteProvider.fetch();
    try {
      final map = jsonDecode(json);
      //
      final sections = _decodeSections(map);
      final farmers = _decodeFarmers(map);
      final categories = _decodeCategories(map, sections);
      final products = _decodeProducts(map, sections, farmers, categories);
      final fullData = CatalogData(
        sections: sections,
        farmers: farmers,
        categories: categories,
        products: products,
      );

      loadFavorites();
      loadFavoriteFilter();
      loadSortFlag();
      loadCategoriesFilter();

      _onDataChanged.add(ModelState.success(data: fullData));

      _onAffectedData.add(fullData.products);
      sortAffected();
    } catch (e) {
      print('$now: CATCH! CatalogModel.load: e=$e');
      _onDataChanged
          .add(ModelState.error(data: CatalogData(), errMessage: e.toString()));
    }
  }

  List<Section> _decodeSections(Map<String, dynamic> map) {
    final sectionList =
        (map[ApiConst.sectionsKey] as List).cast<Map<String, dynamic>>();
    return sectionList
        .map((e) => Section(
              id: e[ApiConst.sectionIdKey] as int,
              title: e[ApiConst.sectionTitleKey],
            ))
        .toList();
  }

  List<Farmer> _decodeFarmers(Map<String, dynamic> map) {
    final farmerList =
        (map[ApiConst.farmersKey] as List).cast<Map<String, dynamic>>();
    return farmerList
        .map((e) => Farmer(
              id: e[ApiConst.farmerIdKey] as int,
              title: e[ApiConst.farmerTitleKey],
            ))
        .toList();
  }

  List<Category> _decodeCategories(
      Map<String, dynamic> map, List<Section> sections) {
    final categoryList =
        (map[ApiConst.categoriesKey] as List).cast<Map<String, dynamic>>();

    return categoryList
        .map((e) => Category(
              id: e[ApiConst.categoryIdKey] as int,
              title: e[ApiConst.categoryTitleKey],
              section: sections.firstWhere(
                  (s) => s.id == e[ApiConst.categorySectionIdKey],
                  orElse: () => null),
              icon: e[ApiConst.categoryIconKey],
            ))
        .toList();
  }

  List<Product> _decodeProducts(
    Map<String, dynamic> map,
    List<Section> sections,
    List<Farmer> farmers,
    List<Category> categories,
  ) {
    final productList =
        (map[ApiConst.productsKey] as List).cast<Map<String, dynamic>>();

    return productList.map((e) {

      final p = Product(
        id: e[ApiConst.productIdKey] as int,
        title: e[ApiConst.productTitleKey],
        section: sections.firstWhere(
            (s) => s.id == e[ApiConst.productSectionIdKey],
            orElse: () => null),
        farmer: farmers.firstWhere(
            (s) => s.id == e[ApiConst.productFarmerIdKey],
            orElse: () => null),
        category: categories.firstWhere(
            (s) => s.id == e[ApiConst.productCategoryIdKey],
            orElse: () => null),
        unit: e[ApiConst.productUnitKey],
        totalRating: e[ApiConst.productTotalRatingKey].toDouble(),
        ratingCount: e[ApiConst.productRatingCountKey],
        image: e[ApiConst.productImageKey],
        shortDescription: e[ApiConst.productShortDescriptionKey],
        description: e[ApiConst.productDescriptionKey],
        price: e[ApiConst.productPriceKey].toDouble(),
        characteristics: (e[ApiConst.productCharacteristicsKey] as List)
            .map((e) => Map<String, String>.from(e)).toList(),
      );
      return p;
    }).toList();
  }

  Future clearFavorites() async {
    final storage = TheLocalStorage;
    await storage.putFavoritesIndices([]);
    final newIndices = await storage.getFavoritesIndices();
    _onFavouriteChanged.add(newIndices);
  }

  Future loadFavorites() async {
    final storage = TheLocalStorage;
    final newIndices = await storage.getFavoritesIndices();
    _onFavouriteChanged.add(newIndices);
  }

  Future loadFavoriteFilter() async {
    final filter = await TheLocalStorage.getFavoritesFilter();
    _onFavoriteFilter.add(filter);
    filterFavorite(filter);
  }

  Future markFavorite(int index, bool mark) async {
    final newFav = List<int>.from(favourite);
    if (mark && !newFav.contains(index)) {
      newFav.add(index);
      newFav.sort();
    } else if (!mark && newFav.contains(index)) {
      newFav.removeWhere((i) => i == index);
    }

    _onFavouriteChanged.add(newFav);
    final storage = TheLocalStorage;
    await storage.putFavoritesIndices(newFav);
  }

  Future filterFavorite(bool on) async {
    var affected = on
        ? value.data.products
            .where((element) => favourite.contains(element.id))
            .toList()
        : value.data.products.where((element) => true).toList();
    _onAffectedData.add(affected);
    sortAffected();
    _onFavoriteFilter.add(on);

    // TODO оптимизировать
    if (categoriesFilter.length > 0) {
      final ff = List<String>.from(categoriesFilter);
      affected = affected.where((e) => ff.contains(e.category.title)).toList();
      _onAffectedData.add(affected);
    }

    _onDataChanged.add(ModelState.success(data: value.data));
    await TheLocalStorage.putFavoritesFilter(on);

    doSortByPrice(sortByPrice);
  }

  Future filterByCategory(String category, bool on) async {
    final ff = List<String>.from(categoriesFilter);
    var affected = List<Product>.from(value.data.products);
    ff.clear();
    if (on) {
      ff.add(category);
    }
    if (ff.length == 0) {
      affected = affected;
    } else {
      affected = affected.where((e) => ff.contains(e.category.title)).toList();
    }

    /// TODO оптимизировать
    if (favoriteFilter) {
      affected =
          affected.where((element) => favourite.contains(element.id)).toList();
      _onFavoriteFilter.add(favoriteFilter);
    }

    _onAffectedData.add(affected);
    _onCategoriesFilter.add(ff);
    _onDataChanged.add(ModelState.success(data: value.data));
    await TheLocalStorage.putCategoriesFilter(ff);

    doSortByPrice(sortByPrice);

//    filterFavorite(_onFavoriteFilter.value);
  }

  Future loadCategoriesFilter() async {
    final f = await TheLocalStorage.getCategoriesFilter();
    _onCategoriesFilter.add(f);
    f.forEach((e) => filterByCategory(e, true));
  }

  ///
  Future doSortByPrice(bool on) async {
    final affected = List<Product>.from(affectedData);
    affected.sort((a, b) => on
        ? (a.price * 100 - b.price * 100).toInt()
        : (a.totalRating * 100 - b.totalRating * 100).toInt());
//    print('$now: CatalogModel.doSortByPrice: on=$on, affected=$affected');
    _onAffectedData.add(affected);
    _onSortByPrice.add(on);
    _onDataChanged.add(ModelState.success(data: value.data));
    await TheLocalStorage.putSortFlag(on);
  }

  Future loadSortFlag() async {
    final flag = await TheLocalStorage.getSortFlag();
    _onSortByPrice.add(flag);
    doSortByPrice(flag);
  }

  void sortAffected() {
    final affected = List<Product>.from(affectedData);
//    print('$now: CatalogModel.sortAffected: affected = ${affected.length}');
    affected
        .sort((a, b) => (a.totalRating * 100 - b.totalRating * 100).toInt());
    _onAffectedData.add(affected);
  }

  @override
  Future dispose() async {
    _onDataChanged.close();
    _onFavoriteFilter.close();
    _onAffectedData.close();
  }
}
