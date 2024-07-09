import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/dashboard/views/desktop_layout/views/desktop_layout.dart';
import 'package:pos_dashboard_v1/features/dashboard/views/mobile_layout/Views/mobile_layout.dart';
import 'package:pos_dashboard_v1/features/dashboard/views/tablet_layout/Views/tablet_layout.dart';
import 'package:pos_dashboard_v1/core/utils/manager.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundColor,
      // appBar: AppBar(
      //   title: const Text('Dashboard'),
      // ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth >= 1200) {
            // Desktop layout
            return const DesktopLayout();
          } else if (constraints.maxWidth >= 600) {
            // Tablet layout
            return const TabletLayout();
          } else {
            // Mobile layout
            return const MobileLayout();
          }
        },
      ),
    );
  }
}
//new branch created
//duhh   
//duhhh branch