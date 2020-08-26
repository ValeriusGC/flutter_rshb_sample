import 'dart:async';

import 'package:meta/meta.dart';
import 'package:frshbsample/ui/nav_service.dart';
import 'package:rxdart/rxdart.dart';

@immutable
class MainPageViewModel {
  static const _timerStartValue = 10;
  static const _timerDurationValue = 1000;

  final timerCell = <Timer>[null];

  final onTick = BehaviorSubject.seeded(_timerStartValue);

  void init() {
    if (timerCell[0] == null) {
      onTick.add(_timerStartValue);
      timerCell[0] =
          Timer.periodic(Duration(milliseconds: _timerDurationValue), (t) {
        onTick.add(onTick.value - 1);
        if (onTick.value < 1) {
          showCatalogPage();
        }
      });
    }
  }

  void showCatalogPage() async {
    navService.pushNamed(NavConst.catalogRoute);
    _cancelTimer();
  }

  void catalogClosed() {
    init();
  }

  void _cancelTimer() {
    timerCell[0]?.cancel();
    timerCell[0] = null;
  }

  void dispose() {
    _cancelTimer();
    onTick.close();
  }
}
