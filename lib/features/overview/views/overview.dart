import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/categories/views/categories/categories_view.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/views/return_invoice_view.dart';
import 'package:pos_dashboard_v1/features/sales_bill/views/sales_bill_view.dart';
import 'package:pos_dashboard_v1/features/prodacts/views/prodacts_list_view.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/total_points_orders_visits_card.dart';
import 'package:pos_dashboard_v1/features/userInformation/views/user_info_card.dart';
import 'package:pos_dashboard_v1/features/userInformation/views/user_info_section.dart';

import '../../../l10n/app_localizations.dart';

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
    // ignore: unused_local_variable
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
                      Row(
                        children: [
                          TotalPointAndOrdersAndVisetsCard(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return OrdersListView(
                                      onProductsCountChanged:
                                          updateProductCount);
                                },
                              ));
                            },
                            title: localizations.translate('البضاعة بالمخزن'),
                            value: "1200",
                            subValue: "Visits: 30",
                            subValuetwo: "Orders: 45",
                            subTitle: "Subtitle",
                            numberOfProductsInStore: numberOfProductsInStore,
                            icon: Icons.store,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 16),
                          TotalPointAndOrdersAndVisetsCard(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const CategoryScreen();
                                  },
                                ),
                              );
                            },
                            title: "الاصناف بالمحل",
                            value: "1200",
                            subValue: "Visits: 30",
                            subValuetwo: "Orders: 45",
                            subTitle: "Subtitle",
                            numberOfProductsInStore: numberOfProductsInStore,
                            icon: Icons.store,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 16),
                          TotalPointAndOrdersAndVisetsCard(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const SalesBillScreen();
                                  },
                                ),
                              );
                            },
                            title: 'انشاء فاتورة مبيعات',
                            value: "1200",
                            subValue: "Visits: 30",
                            subValuetwo: "Orders: 45",
                            subTitle: "Subtitle",
                            icon: Icons.store,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 16),
                          TotalPointAndOrdersAndVisetsCard(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const ReturnInvoiceScreen();
                                  },
                                ),
                              );
                            },
                            title: "المرتجعات",
                            value: "1200",
                            subValue: "Visits: 30",
                            subValuetwo: "Orders: 45",
                            subTitle: "Subtitle",
                            numberOfProductsInStore: numberOfProductsInStore,
                            icon: Icons.store,
                            color: Colors.blue,
                          ),
                        ],
                      )
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
            // OrderList(onProductsCountChanged: updateProductCount),
          ],
        ),
      ),
    );
  }
}
