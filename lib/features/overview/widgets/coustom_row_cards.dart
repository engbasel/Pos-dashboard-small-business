// import 'package:flutter/material.dart';
// import 'package:pos_dashboard_v1/features/dashboard/views/desktop_layout/widgets/TotalPointAndOrdersAndVisetsCard.dart';
// import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

// class CustomRowCards extends StatelessWidget {
//   const CustomRowCards({
//     super.key,
//     required this.width,
//   });

//   final double width;

//   @override
//   Widget build(BuildContext context) {
//     final appLocalizations = AppLocalizations.of(context);

//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: Container(
//         decoration: BoxDecoration(
//             color: Colors.white, borderRadius: BorderRadius.circular(12)),
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               TotalPointAndOrdersAndVisetsCard(
//                 title: appLocalizations.translate('totalPoints'),
//                 value: appLocalizations.translate('pointsUsed'),
//                 subValuetwo: '244\$',
//                 subTitle: appLocalizations.translate('outstandingPoints'),
//                 subValue: '150',
//                 numberOfProdatcsInStore: '300',
//                 icon: Icons.shopping_cart,
//                 color: Colors.green,
//               ),
//               const SizedBox(width: 16),
//               TotalPointAndOrdersAndVisetsCard(
//                 title: appLocalizations.translate('orders'),
//                 value: appLocalizations.translate('totalSpend'),
//                 subValuetwo: '244\$',
//                 subTitle: appLocalizations.translate('averageOrderValue'),
//                 subValue: '150',
//                 numberOfProdatcsInStore: '300',
//                 icon: Icons.shopping_cart,
//                 color: Colors.green,
//               ),
//               const SizedBox(width: 16),
//               TotalPointAndOrdersAndVisetsCard(
//                 title: appLocalizations.translate('totalVisits'),
//                 value: appLocalizations.translate('lastVisit'),
//                 subValuetwo: '244\$',
//                 subTitle: appLocalizations.translate('spendingTimePerDay'),
//                 subValue: '150',
//                 numberOfProdatcsInStore: '300',
//                 icon: Icons.shopping_cart,
//                 color: Colors.green,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:pos_dashboard_v1/features/dashboard/views/desktop_layout/widgets/TotalPointAndOrdersAndVisetsCard.dart';
// import 'package:pos_dashboard_v1/l10n/app_localizations.dart';
// import 'package:pos_dashboard_v1/features/dashboard/views/desktop_layout/models/order_model.dart';

// import '../../../../../core/utils/DB/database_helper_prodactsTable.dart';

// class CustomRowCards extends StatefulWidget {
//   const CustomRowCards({
//     super.key,
//     required this.width,
//   });

//   final double width;

//   @override
//   _CustomRowCardsState createState() => _CustomRowCardsState();
// }

// class _CustomRowCardsState extends State<CustomRowCards> {
//   final DatabaseHelper _databaseHelper = DatabaseHelper();
//   int _numberOfProductsInStore = 0;

//   @override
//   void initState() {
//     super.initState();
//     _updateNumberOfProductsInStore();
//   }

//   Future<void> _updateNumberOfProductsInStore() async {
//     List<Order> orders = await _databaseHelper.getOrders();
//     setState(() {
//       _numberOfProductsInStore = orders.length;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final appLocalizations = AppLocalizations.of(context);

//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: Container(
//         decoration: BoxDecoration(
//             color: Colors.white, borderRadius: BorderRadius.circular(12)),
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               TotalPointAndOrdersAndVisetsCard(
//                 title: appLocalizations.translate('totalPoints'),
//                 value: appLocalizations.translate('pointsUsed'),
//                 subValuetwo: '244\$',
//                 subTitle: appLocalizations.translate('outstandingPoints'),
//                 subValue: '150',
//                 numberOfProductsInStore: _numberOfProductsInStore, // Updated
//                 icon: Icons.shopping_cart,
//                 color: Colors.green,
//               ),
//               const SizedBox(width: 16),
//               TotalPointAndOrdersAndVisetsCard(
//                 title: appLocalizations.translate('orders'),
//                 value: appLocalizations.translate('totalSpend'),
//                 subValuetwo: '244\$',
//                 subTitle: appLocalizations.translate('averageOrderValue'),
//                 subValue: '150',
//                 numberOfProductsInStore: _numberOfProductsInStore, // Updated
//                 icon: Icons.shopping_cart,
//                 color: Colors.green,
//               ),
//               const SizedBox(width: 16),
//               TotalPointAndOrdersAndVisetsCard(
//                 title: appLocalizations.translate('totalVisits'),
//                 value: appLocalizations.translate('lastVisit'),
//                 subValuetwo: '244\$',
//                 subTitle: appLocalizations.translate('spendingTimePerDay'),
//                 subValue: '150',
//                 numberOfProductsInStore: _numberOfProductsInStore, // Updated
//                 icon: Icons.shopping_cart,
//                 color: Colors.green,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/total_points_orders_visits_card.dart';

import '../../../l10n/app_localizations.dart';

class CustomRowCards extends StatelessWidget {
  final double width;
  final int numberOfProductsInStore;

  const CustomRowCards({
    super.key,
    required this.width,
    required this.numberOfProductsInStore,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Row(
      children: [
        TotalPointAndOrdersAndVisetsCard(
          title: localizations.translate('totalPoints'),
          value: "1200",
          subValue: "Visits: 30",
          subValuetwo: "Orders: 45",
          subTitle: "Subtitle",
          numberOfProductsInStore: numberOfProductsInStore,
          icon: Icons.store,
          color: Colors.blue,
        ),
        const SizedBox(width: 16),

        // Add other cards if needed
      ],
    );
  }
}
