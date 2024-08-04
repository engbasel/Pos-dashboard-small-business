// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/features/categories/views/categories/views/categories_view.dart';
import 'package:pos_dashboard_v1/features/reports/views/all_reports_viewer.dart';
import 'package:pos_dashboard_v1/features/notifications/views/notifications_view.dart';
import 'package:pos_dashboard_v1/features/products/views/products_list_view.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/views/return_invoice_view.dart';
import 'package:pos_dashboard_v1/features/sales_bill/views/sales_bill_view.dart';
import 'package:pos_dashboard_v1/features/user_Info/views/user_info_section.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

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

  Widget buildNotificationItem({
    required IconData icon,
    required Color color,
    required String title,
    required String message,
  }) {
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

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double width = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    final localizations = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            title: 'Dashboard',
            actions: [
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationsView(),
                  ),
                ),
                child: const Icon(
                  Icons.notifications_none,
                  color: Color(0xff505251),
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                'Mohamed Elneny',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const UserInfoSection(),
                    const SizedBox(height: 16),
                    // buildQuickAccessButtons(context, localizations),
                    const SizedBox(height: 16),
                    Container(
                      height: 120,
                      width: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.red,
                      ),
                      child: const Center(
                        child:
                            Text('you have enouf count of this item in Store '),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget buildQuickAccessButtons(
      BuildContext context, AppLocalizations localizations) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        buildQuickAccessButton(
          context,
          title: localizations.translate('البضاعة بالمخزن'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProductsListView(),
            ),
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
        buildQuickAccessButton(
          context,
          title: localizations.translate('عرض كافة التقارير'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AllReportesViwer()),
          ),
          icon: Icons.assignment_return,
        ),
        buildQuickAccessButton(
          context,
          title: localizations.translate('الطلبيات القادمة'),
          onPressed: () {},
          icon: Icons.assignment_return,
        ),
      ],
    );
  }
}
