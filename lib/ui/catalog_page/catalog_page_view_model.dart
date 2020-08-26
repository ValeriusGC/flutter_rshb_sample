import 'dart:async';

import 'package:frshbsample/core/model/model.dart';
import 'package:meta/meta.dart';
import 'package:frshbsample/ui/nav_service.dart';
import 'package:rxdart/rxdart.dart';

@immutable
class CatalogPageViewModel implements Model{

  @override
  Future init() async {
  }

  void showDetailPage() async {
    navService.pushNamed(NavConst.detailRoute);
  }

  @override
  Future dispose() async {
  }
}
