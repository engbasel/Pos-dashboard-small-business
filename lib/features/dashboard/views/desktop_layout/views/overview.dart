import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/dashboard/views/desktop_layout/Widgets/order_list.dart';
import 'package:pos_dashboard_v1/features/dashboard/views/desktop_layout/widgets/user_info_section.dart';

class OverviewView extends StatelessWidget {
  const OverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Column(
              children: [
                // user info
                UserInfoScetion(),
                // total point - orders - total visits
                Row(
                  children: [],
                ),
              ],
            ),
            // user card
          ],
        ),
        const SizedBox(height: 16),
        // order list
        OrderList(),
      ],
    );
  }
}
