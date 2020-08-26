import 'dart:async';

import 'package:meta/meta.dart';
import 'package:frshbsample/ui/nav_service.dart';
import 'package:rxdart/rxdart.dart';

@immutable
class CatalogPageViewModel {

  void init() {
  }

  void showDetailPage() async {
    navService.pushNamed(NavConst.detailRoute);
  }

  void dispose() {
  }
}
