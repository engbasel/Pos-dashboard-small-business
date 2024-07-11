import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/dashboard/views/desktop_layout/widgets/coustom_row_cards.dart';
import 'package:pos_dashboard_v1/features/dashboard/views/desktop_layout/widgets/order_list.dart';
import 'package:pos_dashboard_v1/features/dashboard/views/desktop_layout/widgets/user_info_card.dart';
import 'package:pos_dashboard_v1/features/dashboard/views/desktop_layout/widgets/user_info_section.dart';
import 'package:pos_dashboard_v1/features/login/views/loginview.dart';

class OverviewView extends StatelessWidget {
  const OverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
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
                    CustomRowCards(width: width),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                flex: 1,
                child: user_info_card(),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const LoginView();
                      },
                    ));
                  },
                  child: const Text('back'))
            ],
          ),
          const SizedBox(height: 16),
          OrderList(),
        ],
      ),
    );
  }
}
