import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/categories/views/categories/categories_view.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/views/return_invoice_view.dart';
import 'package:pos_dashboard_v1/features/sales_bill/views/sales_bill_view.dart';
import 'package:pos_dashboard_v1/features/prodacts/views/prodacts_list_view.dart';
import 'package:pos_dashboard_v1/features/userInformation/views/user_info_section.dart';
import '../../../l10n/app_localizations.dart';
import '../../userInformation/user_info_card.dart';

class OverviewView extends StatefulWidget {
  const OverviewView({super.key});

  @override
  State<OverviewView> createState() => _OverviewViewState();
}

class _OverviewViewState extends State<OverviewView> {
  int numberOfProductsInStore = 0;

  void updateProductCount(int count) {
    setState(() {
      numberOfProductsInStore = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final localizations = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const UserInfoSection(),
                      const SizedBox(height: 16),
                      buildQuickAccessButtons(context, localizations),
                      const SizedBox(height: 16),
                      buildBusinessSummary(context, localizations),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: user_info_card(),
                ),
              ],
            ),
            const SizedBox(height: 32),
            buildNotificationsSection(context, localizations),
          ],
        ),
      ),
    );
  }

  Widget buildQuickAccessButtons(
      BuildContext context, AppLocalizations localizations) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildQuickAccessButton(
          context,
          title: localizations.translate('البضاعة بالمخزن'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    OrdersListView(onProductsCountChanged: updateProductCount)),
          ),
          icon: Icons.inventory,
        ),
        buildQuickAccessButton(
          context,
          title: localizations.translate('الاصناف بالمحل'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CategoryScreen()),
          ),
          icon: Icons.category,
        ),
        buildQuickAccessButton(
          context,
          title: localizations.translate('انشاء فاتورة مبيعات'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SalesBillScreen()),
          ),
          icon: Icons.receipt,
        ),
        buildQuickAccessButton(
          context,
          title: localizations.translate('المرتجعات'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ReturnInvoiceScreen()),
          ),
          icon: Icons.assignment_return,
        ),
        ElevatedButton(
          onPressed: () {},
          // child: Text(appLocalizations.translate('viewReports')),
          child: const Text('viewReports'),
        ),
        ElevatedButton(
          onPressed: () {},
          // child:
          // Text(appLocalizations.translate('manageInventory')),
          child: const Text('manageInventory'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('newSale'),
        ),
      ],
    );
  }

  Widget buildQuickAccessButton(BuildContext context,
      {required String title,
      required VoidCallback onPressed,
      required IconData icon}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(title),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget buildBusinessSummary(
      BuildContext context, AppLocalizations localizations) {
    return const Row(
      children: [],
    );
  }

  Widget buildNotificationsSection(
      BuildContext context, AppLocalizations localizations) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.translate('Notifications'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          buildNotificationItem(
            icon: Icons.warning,
            color: Colors.orange,
            title: localizations.translate('Low Stock Alert'),
            message:
                localizations.translate('5 products are running low on stock'),
          ),
          buildNotificationItem(
            icon: Icons.event,
            color: Colors.blue,
            title: localizations.translate('Upcoming Sale'),
            message: localizations.translate('Summer sale starts in 2 days'),
          ),
          buildNotificationItem(
            icon: Icons.receipt,
            color: Colors.green,
            title: localizations.translate('New Order'),
            message: localizations.translate('Order #1234 needs processing'),
          ),
        ],
      ),
    );
  }

  Widget buildNotificationItem(
      {required IconData icon,
      required Color color,
      required String title,
      required String message}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(message),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
