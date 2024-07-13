import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/coustom_row_cards.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/order_list.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/user_info_card.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/user_info_section.dart';

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
                      CustomRowCards(
                        width: width,
                        numberOfProductsInStore: numberOfProductsInStore,
                      ),
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
            OrderList(onProductsCountChanged: updateProductCount),
          ],
        ),
      ),
    );
  }
}
