import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:frshbsample/sl.dart';
import 'package:frshbsample/ui/nav_service.dart';

void main() {
  EquatableConfig.stringify = true;
  WidgetsFlutterBinding.ensureInitialized();

  setupGetIt();

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('ru'),
        Locale('en'),
      ],
      path: 'assets/translations', // <-- change patch to your
      fallbackLocale: Locale('ru'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      //
      navigatorKey: NavigationService.navigationKey,
      onGenerateRoute: generateRoute,
      initialRoute: NavConst.mainRoute,
    );
  }
}

