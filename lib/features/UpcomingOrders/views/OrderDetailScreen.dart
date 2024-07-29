// import 'package:flutter/material.dart';
// import '../model/incoming_order_model.dart';

// class OrderDetailScreen extends StatelessWidget {
//   final IncomingOrderModel order;

//   const OrderDetailScreen({super.key, required this.order});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Order Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: <Widget>[
//             ListTile(
//               title: const Text('Order ID'),
//               subtitle: Text(order.orderId),
//             ),
//             ListTile(
//               title: const Text('Supplier Name'),
//               subtitle: Text(order.supplierName),
//             ),
//             ListTile(
//               title: const Text('Order Date'),
//               subtitle: Text(order.orderDate),
//             ),
//             ListTile(
//               title: const Text('Expected Delivery Date'),
//               subtitle: Text(order.expectedDeliveryDate),
//             ),
//             ListTile(
//               title: const Text('Order Status'),
//               subtitle: Text(order.orderStatus),
//             ),
//             ListTile(
//               title: const Text('Total Amount'),
//               subtitle: Text(order.totalAmount.toString()),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../model/incoming_order_model.dart';

class OrderDetailScreen extends StatelessWidget {
  final IncomingOrderModel order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('orderDetails')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(AppLocalizations.of(context).translate('orderId')),
              subtitle: Text(order.orderId),
            ),
            ListTile(
              title:
                  Text(AppLocalizations.of(context).translate('supplierName')),
              subtitle: Text(order.supplierName),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).translate('orderDate')),
              subtitle: Text(order.orderDate),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)
                  .translate('expectedDeliveryDate')),
              subtitle: Text(order.expectedDeliveryDate),
            ),
            ListTile(
              title:
                  Text(AppLocalizations.of(context).translate('orderStatus')),
              subtitle: Text(order.orderStatus),
            ),
            ListTile(
              title:
                  Text(AppLocalizations.of(context).translate('totalAmount')),
              subtitle: Text(order.totalAmount.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
