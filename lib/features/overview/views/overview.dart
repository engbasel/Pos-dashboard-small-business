import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/overview/views/CatigorysViwe.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/coustom_row_cards.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/order_list.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/total_points_orders_visits_card.dart';
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
                                return const CatigorysViwe();
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
                                return const CatigorysViwe();
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
                      TotalPointAndOrdersAndVisetsCard(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const CatigorysViwe();
                              },
                            ),
                          );
                        },
                        title: 'المبيعات',
                        value: "1200",
                        subValue: "Visits: 30",
                        subValuetwo: "Orders: 45",
                        subTitle: "Subtitle",
                        numberOfProductsInStore: numberOfProductsInStore,
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
