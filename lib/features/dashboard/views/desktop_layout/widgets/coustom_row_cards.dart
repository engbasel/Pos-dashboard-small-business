// import 'package:flutter/material.dart';
// import 'package:pos_dashboard_v1/features/dashboard/views/desktop_layout/widgets/TotalPointAndOrdersAndVisetsCard.dart';

// class coustom_row_cards extends StatelessWidget {
//   const coustom_row_cards({
//     super.key,
//     required this.width,
//   });

//   final double width;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: Container(
//         decoration: BoxDecoration(
//             color: Colors.white, borderRadius: BorderRadius.circular(12)),
//         child: const Padding(
//           padding: EdgeInsets.all(10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               TotalPointAndOrdersAndVisetsCard(
//                 title: 'Total Points :',
//                 value: 'Points Used :',
//                 subValuetwo: '244\$',
//                 subTitle: 'Outstanding Points',
//                 subValue: '150',
//                 price: '300',
//                 icon: Icons.shopping_cart,
//                 color: Colors.green,
//               ),
//               SizedBox(width: 16),
//               TotalPointAndOrdersAndVisetsCard(
//                 title: 'Orders :',
//                 value: 'Total Spend :',
//                 subValuetwo: '244\$',
//                 subTitle: 'Average Order Value',
//                 subValue: '150',
//                 price: '300',
//                 icon: Icons.shopping_cart,
//                 color: Colors.green,
//               ),
//               SizedBox(width: 16),
//               TotalPointAndOrdersAndVisetsCard(
//                 title: 'Total Visits :',
//                 value: 'Last Visit :',
//                 subValuetwo: '244\$',
//                 subTitle: 'Spending Time / Day',
//                 subValue: '150',
//                 price: '300',
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
import 'package:pos_dashboard_v1/features/dashboard/views/desktop_layout/widgets/TotalPointAndOrdersAndVisetsCard.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

class CustomRowCards extends StatelessWidget {
  const CustomRowCards({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TotalPointAndOrdersAndVisetsCard(
                title: appLocalizations.translate('totalPoints'),
                value: appLocalizations.translate('pointsUsed'),
                subValuetwo: '244\$',
                subTitle: appLocalizations.translate('outstandingPoints'),
                subValue: '150',
                price: '300',
                icon: Icons.shopping_cart,
                color: Colors.green,
              ),
              const SizedBox(width: 16),
              TotalPointAndOrdersAndVisetsCard(
                title: appLocalizations.translate('orders'),
                value: appLocalizations.translate('totalSpend'),
                subValuetwo: '244\$',
                subTitle: appLocalizations.translate('averageOrderValue'),
                subValue: '150',
                price: '300',
                icon: Icons.shopping_cart,
                color: Colors.green,
              ),
              const SizedBox(width: 16),
              TotalPointAndOrdersAndVisetsCard(
                title: appLocalizations.translate('totalVisits'),
                value: appLocalizations.translate('lastVisit'),
                subValuetwo: '244\$',
                subTitle: appLocalizations.translate('spendingTimePerDay'),
                subValue: '150',
                price: '300',
                icon: Icons.shopping_cart,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
