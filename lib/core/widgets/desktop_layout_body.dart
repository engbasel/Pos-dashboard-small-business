import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/UpcomingOrders/views/add_incoming_order_screen.dart';
import 'package:pos_dashboard_v1/features/categories/views/categories/views/categories_view.dart';
import 'package:pos_dashboard_v1/features/reports/views/all_reports_viewer.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_drawer.dart';
import 'package:pos_dashboard_v1/features/products/views/products_list_view.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/views/return_invoice_view.dart';
import 'package:pos_dashboard_v1/features/sales_bill/views/sales_bill_view.dart';
import 'package:window_manager/window_manager.dart';
import '../../features/client/views/customers_view.dart';
import '../../features/dashboard/views/overview.dart';
import '../../features/settings/views/settings_overview.dart';

class DesktopLayoutBoady extends StatefulWidget {
  const DesktopLayoutBoady({super.key});

  @override
  State<DesktopLayoutBoady> createState() => _DesktopLayoutBoadyState();
}

class _DesktopLayoutBoadyState extends State<DesktopLayoutBoady>
    with WindowListener {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    _init();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  void _init() async {
    // Add this line to override the default close handler
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Are you sure you want to close this window?'),
            actions: [
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Yes'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await windowManager.destroy();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      ProductsListView(),
                      CategoryScreen(),
                      SalesBillScreen(),
                      ReturnInvoiceScreen(),
                      AddIncomingOrderScreen(),
                      AllReportesViwer(),
                      CustomersView(),
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
