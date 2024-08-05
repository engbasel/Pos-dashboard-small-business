import 'dart:io';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';
import 'package:pos_dashboard_v1/core/widgets/desktop_layout_body.dart';
import 'package:provider/provider.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:window_manager/window_manager.dart';

import 'l10n/ocale_provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  WindowOptions windowOptions = const WindowOptions(
    titleBarStyle: TitleBarStyle.normal,
    backgroundColor: Colors.transparent,
    center: true,
    skipTaskbar: false,
    title: 'POS',
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    // await windowManager.show();
    // await windowManager.focus();

    // await windowManager.setResizable(false);
  });

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) {
        return ChangeNotifierProvider(
          create: (context) => LocaleProvider(),
          child: const PosSystem(),
        );
      },
    ),
  );
}

class PosSystem extends StatelessWidget {
  const PosSystem({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      builder: DevicePreview.appBuilder,
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
        scaffoldBackgroundColor: ColorsManager.backgroundColor,
      ),
      // home: const LoginView(),
      home: const DesktopLayoutBoady(),
    );
  }
}
