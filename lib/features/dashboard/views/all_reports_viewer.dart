import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/features/dashboard/views/custom_genral_report_item.dart';

class AllReportesViwer extends StatelessWidget {
  const AllReportesViwer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(title: 'Reports'),
        const SizedBox(height: 16),
        Expanded(
          child: Container(
            color: Colors.white,
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
    );
  }
}
