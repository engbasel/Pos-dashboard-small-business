import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/models/order_model.dart';
import 'package:pos_dashboard_v1/features/dashboard/views/CoustomGenralReportItem.dart';

import '../../Prodacts/views/products_Item_details_view.dart';

class AllReportesViwer extends StatelessWidget {
  List<Order> orders = [];

  AllReportesViwer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Reports'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 4,
          children: [
            CoustomGenralReportItem(
              title: 'تقارير المبيعات',
              onTap: () {},
            ),
            CoustomGenralReportItem(
              title: 'تقارير سجل دخول العاملين للنظام',
              onTap: () {},
            ),
            CoustomGenralReportItem(
              title: 'تقارير المسترجعات',
              onTap: () {},
            ),
            CoustomGenralReportItem(
              title: 'اتقارير لبضاعة بالمخزن',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return OrderDetailsScreen(orders: orders);
                    //  OrdersListView(
                    //   onProductsCountChanged: (value) {},
                    // );
                  },
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
