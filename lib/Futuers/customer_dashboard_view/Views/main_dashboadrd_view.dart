import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/Futuers/customer_dashboard_view/Views/DesktopLayout/views/DesktopLayout.dart';
import 'package:pos_dashboard_v1/Futuers/customer_dashboard_view/Views/MobileLayout/Views/MobileLayout.dart';
import 'package:pos_dashboard_v1/Futuers/customer_dashboard_view/Views/TabletLayout/Views/TabletLayout.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
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