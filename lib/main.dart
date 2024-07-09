import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/Futuers/customer_dashboard_view/Views/main_dashboadrd_view.dart';

void main(List<String> args) {
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
      home: const DashboardView(),
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

//test now
