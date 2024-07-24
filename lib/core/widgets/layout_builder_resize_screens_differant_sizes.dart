import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/overview/views/desktop_layout_body.dart';
import 'package:pos_dashboard_v1/features/reponsive_dashboard/views/mobile_layout/Views/mobile_layout.dart';
import 'package:pos_dashboard_v1/features/reponsive_dashboard/views/tablet_layout/Views/tablet_layout.dart';
import 'package:pos_dashboard_v1/core/utils/Manager/manager.dart';

// ignore: camel_case_types
class LayoutBuilder_resize_screens_defrant_sizes extends StatelessWidget {
  const LayoutBuilder_resize_screens_defrant_sizes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundColor,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth >= 910) {
            // 1200
            // Desktop layout
            return const DesktopLayoutBoady();
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
