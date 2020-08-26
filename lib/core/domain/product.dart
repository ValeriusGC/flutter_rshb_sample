import 'package:equatable/equatable.dart';
import 'category.dart';
import 'farmer.dart';
import 'section.dart';

/// Represents product itself in domain data.
class Product extends Equatable {
  /// Unique identifier.
  final int id;

  /// Product [Section].
  final Section section;

  /// Product [Category].
  final Category category;

  /// Product [Farmer].
  final Farmer farmer;

  /// Title.
  final String title;

  /// Measure unit.
  final String unit;

  /// Rating of product.
  final double totalRating;

  /// Rating count.
  final int ratingCount;

  /// Path to local image for product.
  final String image;

  /// Short description for product.
  final String shortDescription;

  /// Extended description for product.
  final String description;

  /// Price of product.
  final double price;

  /// List of auxiliary characteristics.
  final List<Map<String, String>> characteristics;

  Product({
    this.id,
    this.title,
    this.section,
    this.category,
    this.farmer,
    this.unit,
    this.totalRating,
    this.ratingCount,
    this.image,
    this.shortDescription,
    this.description,
    this.price,
    this.characteristics,
  });

  @override
  List<Object> get props => [
        id,
        title,
        section,
        category,
        farmer,
        unit,
        totalRating,
        ratingCount,
        shortDescription,
        description,
        price,
        characteristics,
      ];
}
