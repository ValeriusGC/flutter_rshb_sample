import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class ModelState<D> extends Equatable {
  final D data;
  final bool isLoading;
  final bool isSuccess;
  final String errMessage;

  ModelState.loading({D data})
      : this._(
          data: data,
          isLoading: true,
          isSuccess: false,
          errMessage: null,
        );

  ModelState.success({D data})
      : this._(
          data: data,
          isLoading: false,
          isSuccess: true,
          errMessage: null,
        );

  ModelState.error({D data, String errMessage})
      : this._(
          data: data,
          isLoading: false,
          isSuccess: false,
          errMessage: errMessage,
        );

  ModelState._({
    this.data,
    this.isLoading,
    this.isSuccess,
    this.errMessage,
  });

  @override
  List<Object> get props => [data, isLoading, isSuccess, errMessage];
}

///
abstract class Model {
  Future init();
  Future dispose();
}
