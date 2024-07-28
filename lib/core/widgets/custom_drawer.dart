import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/dashboard/widgets/drawer_item.dart';
import 'package:pos_dashboard_v1/features/login/views/login_view.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

import '../utils/manager/manager.dart';

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
    final localizations = AppLocalizations.of(context);

    return Container(
      width: MediaQuery.of(context).size.width * .17,
      color: ColorsManager.drawerColor,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .2,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Duh',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      'hhh',
                      style: TextStyle(
                        color: Color(0xff4985FF),
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          drawerItem(
            index: 0,
            icon: Icons.dashboard_outlined,
            text: localizations.translate('dashboard'),
            isSelected: selectedIndex == 0,
            onTap: () {
              onSelectItem(0);
            },
          ),
          drawerItem(
            index: 1,
            icon: Icons.shopping_bag_outlined,
            // text: 'Products',
            text: localizations.translate('Products'),

            isSelected: selectedIndex == 1,
            onTap: () {
              onSelectItem(1);
            },
          ),
          drawerItem(
            index: 2,
            icon: Icons.category_outlined,
            // text: 'Categories',
            text: localizations.translate('catigoryes'),

            isSelected: selectedIndex == 2,
            onTap: () {
              onSelectItem(2);
            },
          ),
          drawerItem(
            index: 3,
            icon: Icons.shopping_cart_outlined,
            // text: 'Orders',
            text: localizations.translate('orders'),

            isSelected: selectedIndex == 3,
            onTap: () {
              onSelectItem(3);
            },
          ),
          drawerItem(
            index: 4,
            icon: Icons.assignment_return_outlined,
            // text: 'Return Invoices',
            text: localizations.translate('ReturnInvoices'),

            isSelected: selectedIndex == 4,
            onTap: () {
              onSelectItem(4);
            },
          ),
          drawerItem(
            index: 5,
            icon: Icons.inventory_outlined,
            // text: 'Needed Products',
            text: localizations.translate('NeededProducts'),

            isSelected: selectedIndex == 5,
            onTap: () {
              onSelectItem(5);
            },
          ),
          drawerItem(
            index: 6,
            icon: Icons.my_library_books_outlined,
            // text: 'reports',

            text: localizations.translate('reports'),

            isSelected: selectedIndex == 6,
            onTap: () {
              onSelectItem(6);
            },
          ),
          drawerItem(
            index: 7,
            icon: Icons.people_alt_outlined,
            text: localizations.translate('customers'),
            isSelected: selectedIndex == 7,
            onTap: () {
              onSelectItem(7);
            },
          ),
          const Spacer(),
          drawerItem(
            index: 8,
            icon: Icons.settings,
            text: localizations.translate('settings'),
            isSelected: selectedIndex == 8,
            onTap: () {
              onSelectItem(8);
            },
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginView();
                  },
                ),
                (route) => false,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 35),
                const Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    localizations.translate('logout'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .05),
        ],
      ),
    );
  }
}
