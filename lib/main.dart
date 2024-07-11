import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/login/views/loginview.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main(List<String> args) {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(const pos_system());
}

// ignore: camel_case_types
class pos_system extends StatelessWidget {
  const pos_system({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginView(),
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
