import 'package:equatable/equatable.dart';

/// Represents farmer of [Product] in domain data.
class Farmer extends Equatable {
  /// Unique identifier.
  final int id;

  /// Title.
  final String title;

  Farmer({this.title, this.id});

  @override
  List<Object> get props => [id, title];
}
