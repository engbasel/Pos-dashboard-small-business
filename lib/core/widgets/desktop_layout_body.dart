import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/upcoming_orders/views/needed_products_view.dart';
import 'package:pos_dashboard_v1/features/categories/views/categories/views/categories_view.dart';
import 'package:pos_dashboard_v1/features/reports/views/all_reports_viewer.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_drawer.dart';
import 'package:pos_dashboard_v1/features/products/views/products_list_view.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/views/return_invoice_view.dart';
import 'package:pos_dashboard_v1/features/sales_bill/views/sales_bill_view.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';
import 'package:window_manager/window_manager.dart';
import '../../features/client/views/customers_view.dart';
import '../../features/overview/views/overview_view.dart';
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
            title: Text(
              AppLocalizations.of(context).translate('AlertDiloageCloseApp'),
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  AppLocalizations.of(context).translate('No'),
                  style: const TextStyle(
                    color: Colors.green,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  AppLocalizations.of(context).translate('Yes'),
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
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
                      NeededProductsView(),
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
