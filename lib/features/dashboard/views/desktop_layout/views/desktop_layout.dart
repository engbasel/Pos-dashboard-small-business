import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/dashboard/views/desktop_layout/views/messages.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_drawer.dart';
import 'customers.dart';
import 'overview.dart';
import 'settings.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        selectedIndex: _selectedIndex,
        onSelectItem: _onItemTapped,
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xfff8f9fd),
        elevation: 0,
        title: const Text('POS Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _onItemTapped(3);
            },
          )
        ],
      ),
      backgroundColor: const Color(0xfff8f9fd),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      OverviewView(),
                      CustomersView(),
                      SettingsView(),
                      MessagesView(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
