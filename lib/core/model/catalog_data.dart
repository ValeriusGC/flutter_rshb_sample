import 'package:equatable/equatable.dart';
import 'package:frshbsample/core/domain/category.dart';
import 'package:frshbsample/core/domain/farmer.dart';
import 'package:frshbsample/core/domain/product.dart';
import 'package:frshbsample/core/domain/section.dart';

///
class CatalogData extends Equatable {
  final List<Product> products;
  final List<Category> categories;
  final List<Section> sections;
  final List<Farmer> farmers;

  CatalogData({
    this.products: const <Product>[],
    this.categories: const <Category>[],
    this.sections: const <Section>[],
    this.farmers: const <Farmer>[],
  });

  @override
  List<Object> get props => [products, categories, sections, farmers];
}
