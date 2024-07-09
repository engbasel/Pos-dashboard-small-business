import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/Futuers/customer_dashboard_view/Views/DesktopLayout/views/Messages.dart';
import '../../../Widgets/CustomDrawer.dart';
import 'Customers.dart';
import 'Overview.dart';
import 'Settings.dart';

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
      appBar: AppBar(),
      drawer: CustomDrawer(
        selectedIndex: selectedDrawerIndex,
        onSelectItem: onSelectDrawerItem,
      ),
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
