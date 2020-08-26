abstract class LocalStorage {
  ///
  Future init([covariant dynamic args]);

  ///
  Future<List<int>> getFavoritesIndices();

  ///
  Future putFavoritesIndices(List<int> indices);

  Future putFavoritesFilter(bool on);

  Future<bool> getFavoritesFilter();

  Future putCategoriesFilter(List<String> filter);

  Future<List<String>> getCategoriesFilter();

  Future putSortFlag(bool on);

  Future<bool> getSortFlag();
}

