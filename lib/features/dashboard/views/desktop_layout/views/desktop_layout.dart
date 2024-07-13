import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/messages/view/MessagesView.dart';
import 'package:pos_dashboard_v1/core/utils/widgets/custom_drawer.dart';
import '../../../../clinet/views/customers_view.dart';
import 'overview.dart';
import '../../../../settings/view/settings.dart';

class DesktopLayoutBoady extends StatefulWidget {
  const DesktopLayoutBoady({super.key});

  @override
  State<DesktopLayoutBoady> createState() => _DesktopLayoutBoadyState();
}

class _DesktopLayoutBoadyState extends State<DesktopLayoutBoady> {
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
        title: const Text(' Dashboard'),
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
