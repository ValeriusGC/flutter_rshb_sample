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

const MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      //
      navigatorKey: NavigationService.navigationKey,
      onGenerateRoute: generateRoute,
      //initialRoute: NavConst.catalogRoute,
      initialRoute: NavConst.mainRoute,
    );
  }
}

