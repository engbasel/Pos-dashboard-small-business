// import 'package:flutter/material.dart';
// import 'package:pos_dashboard_v1/manager.dart';

// class DesktopLayout extends StatefulWidget {
//   const DesktopLayout({super.key});

//   @override
//   State<DesktopLayout> createState() => _DesktopLayoutState();
// }

// class _DesktopLayoutState extends State<DesktopLayout> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       drawer: const CustomDrawer(),
//       body: const Row(
//         children: [
//           // Add other widgets for the main content of your desktop layout
//         ],
//       ),
//     );
//   }
// }

// class CustomDrawer extends StatelessWidget {
//   const CustomDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: ColorsManager.drawerColor,
//       child: ListView(
//         padding: const EdgeInsets.only(top: 125),
//         children: [
//           DrawerItem(
//             icon: Icons.dashboard,
//             text: 'Overview',
//             onTap: () {},
//           ),
//           DrawerItem(
//             icon: Icons.people,
//             text: 'Customers',
//             isSelected: true,
//             onTap: () {},
//           ),
//           DrawerItem(
//             icon: Icons.settings,
//             text: 'Settings',
//             onTap: () {},
//           ),
//           DrawerItem(
//             icon: Icons.message,
//             text: 'Messages',
//             onTap: () {},
//             badgeCount: 5,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget DrawerItem({
//     required IconData icon,
//     required String text,
//     GestureTapCallback? onTap,
//     bool isSelected = false,
//     int badgeCount = 0,
//   }) {
//     return ListTile(
//       title: Row(
//         children: <Widget>[
//           Icon(
//             icon,
//             color: isSelected ? ColorsManager.selectedIconColor : null,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 8.0),
//             child: Text(
//               text,
//               style: TextStyle(
//                 color: isSelected ? ColorsManager.TextColor : null,
//               ),
//             ),
//           ),
//           if (badgeCount > 0)
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0),
//               child: Container(
//                 padding: const EdgeInsets.all(2),
//                 decoration: BoxDecoration(
//                   color: ColorsManager.badgeColor,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 constraints: const BoxConstraints(
//                   minWidth: 16,
//                   minHeight: 16,
//                 ),
//                 child: Center(
//                   child: Text(
//                     '$badgeCount',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//       selected: isSelected,
//       onTap: onTap,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/manager.dart';

import '../Widgets/drwer_item.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  int selectedDrawerIndex = 0;

  void onSelectDrawerItem(int index) {
    setState(() {
      selectedDrawerIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: CustomDrawer(
        selectedIndex: selectedDrawerIndex,
        onSelectItem: onSelectDrawerItem,
      ),
      body: const Row(
        children: [
          // Add other widgets for the main content of your desktop layout
        ],
      ),
    );
  }
}

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
      backgroundColor: selectedIndex >= 0
          ? ColorsManager.drawerColor
          : ColorsManager.drawerColor,
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
