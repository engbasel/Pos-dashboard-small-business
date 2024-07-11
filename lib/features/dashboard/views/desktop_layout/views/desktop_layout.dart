import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/dashboard/views/desktop_layout/views/messages.dart';
import 'package:pos_dashboard_v1/features/dashboard/widgets/custom_drawer.dart';
import 'package:pos_dashboard_v1/features/login/log_users.dart';
import 'customers.dart';
import 'overview.dart';
import 'settings.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  int selectedDrawerIndex = 0;

  void onSelectDrawerItem(int index) {
    setState(() {
      selectedDrawerIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      drawer: CustomDrawer(
        selectedIndex: selectedDrawerIndex,
        onSelectItem: onSelectDrawerItem,
      ),
      backgroundColor: const Color(0xfff8f9fd),
      body: IndexedStack(
        index: selectedDrawerIndex,
        children: const [
          OverviewView(),
          CustomersView(),
          SettingsView(),
          MessagesView(),
        ],
      ),
    );
  }
}
