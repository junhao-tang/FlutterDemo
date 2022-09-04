import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/models/user.dart';
import 'package:flutter_demo/setting.dart';
import 'package:flutter_demo/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Settings settings = await Settings.initSettings(kDebugMode);

  runApp(
    MultiProvider(
      providers: [
        // use provider (most basic) if we do not need notify mechanism (repaint)
        Provider(create: (context) => User("Jasper")),
        ChangeNotifierProvider(
          create: (context) => settings,
        ),
      ],
      child: const SpotifyUiDemoApp(),
    ),
  );
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        // etc.
      };
}

class SpotifyUiDemoApp extends StatelessWidget {
  const SpotifyUiDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(
      builder: (context, value, child) => MaterialApp.router(
        routeInformationProvider: routes.routeInformationProvider,
        routeInformationParser: routes.routeInformationParser,
        routerDelegate: routes.routerDelegate,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English, no country code
          Locale('zh', ''), // Chinese, no country code
        ],
        locale: value.locale,
        scrollBehavior: MyCustomScrollBehavior().copyWith(scrollbars: false),
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context).appTitle,
        theme: getTheme(context),
      ),
    );
  }
}
