import 'dart:convert';
import 'package:frshbsample/core/common/funcs.dart';
import 'package:hive/hive.dart';
import 'local_storage.dart';

class LocalHiveStorageImpl implements LocalStorage {
  static const _commonBoxName = 'common';
  static const _favoriteIndicesKey = 'fav';
  static const _favoriteFilterKey = 'fav_filter';
  static const _categoryFilterKey = 'cat_filter';
  static const _sortFlagKey = 'sort_flag';
  final _db = Hive;
  final _boxName = _commonBoxName;

  LocalHiveStorageImpl() {
//    print('$now: LocalHiveStorageImpl.LocalHiveStorageImpl: ');
  }

  @override
  Future<void> init([covariant String args]) async {
//    print('$now: LocalHiveStorageImpl.init.1: args=$args');
    _db.init(args);
    return;
  }

  @override
  Future<List<int>> getFavoritesIndices() async {
    final s = (await _db.openBox(_boxName)).get(_favoriteIndicesKey) ?? '[]';
    final l = (jsonDecode(s) as List).cast<int>();
    return l;
  }

  @override
  Future putFavoritesIndices(List<int> indices) async {
    final s = jsonEncode(indices);
    (await _db.openBox(_boxName)).put(_favoriteIndicesKey, s);
  }

  Future putFavoritesFilter(bool on) async {
    (await _db.openBox(_boxName)).put(_favoriteFilterKey, on ? 1 : 0);
  }

  Future<bool> getFavoritesFilter() async {
    final s =
        ((await _db.openBox(_boxName)).get(_favoriteFilterKey) ?? 0) as int;
    final l = s == 1 ? true : false;
    return l;
  }

  Future putCategoriesFilter(List<String> filter) async {
    final s = jsonEncode(filter);
    (await _db.openBox(_boxName)).put(_categoryFilterKey, s);
  }

  Future<List<String>> getCategoriesFilter() async {
    final s = (await _db.openBox(_boxName)).get(_categoryFilterKey) ?? '[]';
    final l = (jsonDecode(s) as List).cast<String>();
    return l;
  }

  Future putSortFlag(bool on) async {
    (await _db.openBox(_boxName)).put(_sortFlagKey, on ? 1 : 0);
  }

  Future<bool> getSortFlag() async {
    final s = ((await _db.openBox(_boxName)).get(_sortFlagKey) ?? 0) as int;
    final l = s == 1 ? true : false;
    return l;
  }
}
