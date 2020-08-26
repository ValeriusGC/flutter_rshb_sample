
/// Constants for stub API
abstract class ApiConst {
  static const sectionsKey = 'sections';
  static const sectionIdKey = 'id';
  static const sectionTitleKey = 'title';
  static const farmersKey = 'farmers';
  static const farmerIdKey = 'id';
  static const farmerTitleKey = 'title';
  static const categoriesKey = 'categories';
  static const categoryIdKey = 'id';
  static const categoryTitleKey = 'title';
  static const categorySectionIdKey = 'sectionId';
  static const categoryIconKey = 'icon';
  static const productsKey = 'products';
  static const productIdKey = 'id';
  static const productTitleKey = 'title';
  static const productSectionIdKey = 'sectionId';
  static const productFarmerIdKey = 'farmerId';
  static const productCategoryIdKey = 'categoryId';
  static const productUnitKey = 'unit';
  static const productTotalRatingKey = 'totalRating';
  static const productRatingCountKey = 'ratingCount';
  static const productImageKey = 'image';
  static const productShortDescriptionKey = 'shortDescription';
  static const productDescriptionKey = 'description';
  static const productPriceKey = 'price';
  static const productCharacteristicsKey = 'characteristics';
}

/// Interface for remote provider.
abstract class RemoteProvider {
  Future<String> fetch();
}
