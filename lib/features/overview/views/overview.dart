import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/Catigorys/views/CatigorysScreen.dart';
import 'package:pos_dashboard_v1/features/RetuernsInvoices/views/ReturnInvoiceScreen.dart';
import 'package:pos_dashboard_v1/features/Sales_bill/salesbillScreen.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/order_list.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/TotalPointAndOrdersAndVisetsCard.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/user_info_card.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/user_info_section.dart';

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
                      // CustomRowCards(
                      //   width: width,
                      //   numberOfProductsInStore: numberOfProductsInStore,
                      // ),

                      TotalPointAndOrdersAndVisetsCard(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return OrderList(
                                  onProductsCountChanged: updateProductCount);
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
                        title: "الاصناف",
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
                      const SizedBox(width: 16),
                      // TotalPointAndOrdersAndVisetsCard(
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) {
                      //           return const Returnsinvoice();
                      //         },
                      //       ),
                      //     );
                      //   },
                      //   title: 'المبيعات',
                      //   value: "1200",
                      //   subValue: "Visits: 30",
                      //   subValuetwo: "Orders: 45",
                      //   subTitle: "Subtitle",
                      //   numberOfProductsInStore: numberOfProductsInStore,
                      //   icon: Icons.store,
                      //   color: Colors.blue,
                      // ),
                      // const SizedBox(width: 16),
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
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  flex: 1,
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
