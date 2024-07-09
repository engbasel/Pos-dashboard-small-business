import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/Futuers/customer_dashboard_view/Views/DesktopLayout/Widgets/drwer_item.dart';

import '../../../core/Utls/manager.dart';

class CustomDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelectItem;

  const CustomDrawer({
    super.key,
    required this.selectedIndex,
    required this.onSelectItem,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorsManager.drawerColor,
      child: ListView(
        padding: const EdgeInsets.only(top: 125),
        children: [
          DrawerItem(
            index: 0,
            icon: Icons.dashboard,
            text: 'Overview',
            isSelected: selectedIndex == 0,
            onTap: () {
              onSelectItem(0);
            },
          ),
          DrawerItem(
            index: 1,
            icon: Icons.people,
            text: 'Customers',
            isSelected: selectedIndex == 1,
            onTap: () {
              onSelectItem(1);
            },
          ),
          DrawerItem(
            index: 2,
            icon: Icons.settings,
            text: 'Settings',
            isSelected: selectedIndex == 2,
            onTap: () {
              onSelectItem(2);
            },
          ),
          DrawerItem(
            index: 3,
            icon: Icons.message,
            text: 'Messages',
            isSelected: selectedIndex == 3,
            onTap: () {
              onSelectItem(3);
            },
            badgeCount: 5,
          ),
        ],
      ),
    );
  }
}
