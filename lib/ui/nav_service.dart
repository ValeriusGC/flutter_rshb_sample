import 'package:flutter/material.dart';
import 'package:frshbsample/core/domain/product.dart';

import 'catalog_page/catalog_page.dart';
import 'detail_page/detail_page.dart';
import 'main_page/main_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case NavConst.mainRoute:
      return MaterialPageRoute(
        builder: (_) => MainPage(/*args: settings?.arguments,*/),
      );
    case NavConst.catalogRoute:
      return MaterialPageRoute(
        builder: (_) => CatalogPage(/*args: settings?.arguments*/),
      );
    case NavConst.detailRoute:
      return MaterialPageRoute(
        builder: (_) => DetailPage(product: settings?.arguments as Product),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No path for ${settings?.name}'),
          ),
        ),
      );
  }
}

///
final NavigationService navService = NavigationService();

class NavigationService<T, U> {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  Future<T> pushNamed(String routeName, {Object args}) async {
    return await navigationKey.currentState.pushNamed<T>(
      routeName,
      arguments: args,
    );
  }

  Future<T> push(Route<T> route) async {
    return await navigationKey.currentState.push<T>(route);
  }

  Future<T> pushReplacementNamed(String routeName, {Object args}) async {
    return await navigationKey.currentState.pushReplacementNamed<T, U>(
      routeName,
      arguments: args,
    );
  }

  Future<T> pushNamedAndRemoveUntil(String routeName, {Object args}) async {
    return await navigationKey.currentState.pushNamedAndRemoveUntil<T>(
      routeName,
          (Route<dynamic> route) => false,
      arguments: args,
    );
  }

  Future<bool> maybePop([Object args]) async {
    return await navigationKey.currentState.maybePop<bool>(args);
  }

  bool canPop() => navigationKey.currentState.canPop();

  void goBack({T result}) => navigationKey.currentState.pop<T>(result);
}

abstract class NavConst {
  static const String startRoute = '/';
  static const String mainRoute = 'main';
  static const String catalogRoute = 'catalog';
  static const String detailRoute = 'detail';
}

///
class RouteArgs {
  final String fromRoute;
  final Map<String, dynamic> args;

  RouteArgs({this.fromRoute, this.args});
}

RouteArgs safeRouteArgs(RouteArgs args) =>
    (args ?? RouteArgs(fromRoute: '', args: {}));
