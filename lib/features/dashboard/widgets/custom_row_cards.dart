// import 'package:flutter/material.dart';
// import 'package:pos_dashboard_v1/features/retuerns_invoices/views/return_invoice_view.dart';
// import 'package:pos_dashboard_v1/features/overview/widgets/total_points_orders_visits_card.dart';

// import '../../../l10n/app_localizations.dart';

// class CustomRowCards extends StatelessWidget {
//   final double width;
//   final int numberOfProductsInStore;

//   const CustomRowCards({
//     super.key,
//     required this.width,
//     required this.numberOfProductsInStore,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final localizations = AppLocalizations.of(context);

//     return Row(
//       children: [
//         TotalPointAndOrdersAndVisetsCard(
//           onTap: () {},
//           title: localizations.translate('البضاعة بالمخزن'),
//           value: "1200",
//           subValue: "Visits: 30",
//           subValuetwo: "Orders: 45",
//           subTitle: "Subtitle",
//           numberOfProductsInStore: numberOfProductsInStore,
//           icon: Icons.store,
//           color: Colors.blue,
//         ),
//         const SizedBox(width: 16),
//         TotalPointAndOrdersAndVisetsCard(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) {
//                   return const ReturnInvoiceScreen();
//                 },
//               ),
//             );
//           },
//           title: "الاصناف بالمحل",
//           value: "1200",
//           subValue: "Visits: 30",
//           subValuetwo: "Orders: 45",
//           subTitle: "Subtitle",
//           numberOfProductsInStore: numberOfProductsInStore,
//           icon: Icons.store,
//           color: Colors.blue,
//         ),
//         const SizedBox(width: 16),
//         TotalPointAndOrdersAndVisetsCard(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) {
//                   return const ReturnInvoiceScreen();
//                 },
//               ),
//             );
//           },
//           title: "المرتجعات",
//           value: "1200",
//           subValue: "Visits: 30",
//           subValuetwo: "Orders: 45",
//           subTitle: "Subtitle",
//           numberOfProductsInStore: numberOfProductsInStore,
//           icon: Icons.store,
//           color: Colors.blue,
//         ),
//         const SizedBox(width: 16),
//         TotalPointAndOrdersAndVisetsCard(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) {
//                   return const ReturnInvoiceScreen();
//                 },
//               ),
//             );
//           },
//           title: 'المبيعات',
//           value: "1200",
//           subValue: "Visits: 30",
//           subValuetwo: "Orders: 45",
//           subTitle: "Subtitle",
//           numberOfProductsInStore: numberOfProductsInStore,
//           icon: Icons.store,
//           color: Colors.blue,
//         ),
//         const SizedBox(width: 16),
//         // Add other cards if needed
//       ],
//     );
//   }
// }