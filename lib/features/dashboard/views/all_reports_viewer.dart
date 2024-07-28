import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';
import 'package:pos_dashboard_v1/features/dashboard/views/custom_genral_report_item.dart';

class AllReportesViwer extends StatelessWidget {
  const AllReportesViwer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        title: const Text('Reports'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back))
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              color: ColorsManager.backgroundColor,
              margin: const EdgeInsets.symmetric(horizontal: 16),
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
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
