import 'package:equatable/equatable.dart';

import 'section.dart';

/// Represents category of [Product] in domain data.
class Category extends Equatable {
  /// Unique identifier.
  final int id;

  /// [Section] for this one.
  final Section section;

  /// Title.
  final String title;

  /// Path to local icon.
  final String icon;

  Category({this.id, this.section, this.title, this.icon});

  @override
  List<Object> get props => [id, section, title];
}
