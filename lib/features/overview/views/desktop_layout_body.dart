import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/categories/views/categories/categories_view.dart';
import 'package:pos_dashboard_v1/features/notifications/views/notifications_view.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_drawer.dart';
import 'package:pos_dashboard_v1/features/prodacts/views/prodacts_list_view.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/views/return_invoice_view.dart';
import '../../client/views/customers_view.dart';
import 'overview.dart';
import '../../settings/views/settings_overview.dart';

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
      // appBar: AppBar(
      //   backgroundColor: const Color(0xfff8f9fd),
      //   elevation: 0,
      //   title: const Text(' Dashboard'),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.logout_rounded),
      //       onPressed: () {
      //         // _onItemTapped(3);

      //         Navigator.push(context, MaterialPageRoute(
      //           builder: (context) {
      //             return const LoginView();
      //           },
      //         ));
      //       },
      //     )
      //   ],
      // ),
      backgroundColor: const Color(0xfff8f9fd),
      body: Row(
        children: [
          CustomDrawer(
            selectedIndex: _selectedIndex,
            onSelectItem: _onItemTapped,
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      OverviewView(),
                      OrdersListView(),
                      CategoryScreen(),
                      ReturnInvoiceScreen(),
                      CustomersView(),
                      Notificationsviwe(),
                      SettingsView(),
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
