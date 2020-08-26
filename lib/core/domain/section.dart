import 'package:equatable/equatable.dart';

/// Represents section of [Product] in domain data.
class Section extends Equatable {
  /// Unique identifier.
  final int id;

  /// Title.
  final String title;

  Section({this.title, this.id});

  @override
  List<Object> get props => [id, title];
}
