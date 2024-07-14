import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/login/views/login_view.dart';
import 'package:pos_dashboard_v1/features/settings/view/Staffview.dart';
import 'package:provider/provider.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/ocale_provider.dart';

void main(List<String> args) {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: const PosSystem(),
    ),
  );
}

class PosSystem extends StatelessWidget {
  const PosSystem({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      locale: localeProvider.locale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'EG'),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const LoginView(),
      home: const Staffview(),
      // home: const DesktopLayoutBoady(),
    );
  }
}
// ----------------------------------
// disgen Link
// ----------------------------------
// https://www.figma.com/design/sa77wX8SKrQpkCc1W7RAgf/POS-System-Dashboard-Dark-(Community)?node-id=1-14&t=a9INnTrgS1dYpRAR-0
// ----------------------------------
// requirements
// 1- Logic work
// 2- UI done
// 3- Localizations
// 4- dark theme -with them
// ----------------------------------

//test again
