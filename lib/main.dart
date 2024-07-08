import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/Futuers/Views/main_dashboadrd_view.dart';

void main(List<String> args) {
  runApp(const POS_system());
}

class POS_system extends StatelessWidget {
  const POS_system({super.key});

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
