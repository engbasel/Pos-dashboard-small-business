// import 'package:flutter/material.dart';
// import 'package:pos_dashboard_v1/features/UpcomingOrders/database/database_incoming_orders_manager..dart';
// import 'package:pos_dashboard_v1/features/UpcomingOrders/model/incoming_order_model.dart';
// import 'package:pos_dashboard_v1/features/UpcomingOrders/views/OrderDetailScreen.dart';
// import 'package:pos_dashboard_v1/features/UpcomingOrders/views/add_incoming_order_screen.dart';

// class IncomingOrdersListScreen extends StatefulWidget {
//   const IncomingOrdersListScreen({super.key});

//   @override
//   _IncomingOrdersListScreenState createState() =>
//       _IncomingOrdersListScreenState();
// }

// class _IncomingOrdersListScreenState extends State<IncomingOrdersListScreen> {
//   late Future<List<IncomingOrderModel>> _incomingOrdersFuture;

//   @override
//   void initState() {
//     super.initState();
//     _incomingOrdersFuture = DatabaseIncomingOrdersManager().getIncomingOrders();
//   }

//   void _navigateToAddOrderScreen() async {
//     final newOrder = await Navigator.push<IncomingOrderModel>(
//       context,
//       MaterialPageRoute(builder: (context) => const AddIncomingOrderScreen()),
//     );

//     if (newOrder != null) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => OrderDetailScreen(order: newOrder),
//         ),
//       );
//     }

//     setState(() {
//       _incomingOrdersFuture =
//           DatabaseIncomingOrdersManager().getIncomingOrders();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Incoming Orders'),
//       ),
//       body: FutureBuilder<List<IncomingOrderModel>>(
//         future: _incomingOrdersFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No incoming orders found'));
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final order = snapshot.data![index];
//                 return ListTile(
//                   title: Text(order.orderId),
//                   subtitle: Text(order.supplierName),
//                   trailing: Text(order.orderStatus),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => OrderDetailScreen(order: order),
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _navigateToAddOrderScreen,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/UpcomingOrders/database/database_incoming_orders_manager..dart';
import 'package:pos_dashboard_v1/features/UpcomingOrders/model/incoming_order_model.dart';
import 'package:pos_dashboard_v1/features/UpcomingOrders/views/order_detail_screen.dart';
import 'package:pos_dashboard_v1/features/UpcomingOrders/views/add_incoming_order_screen.dart';
import '../../../l10n/app_localizations.dart';

class IncomingOrdersListScreen extends StatefulWidget {
  const IncomingOrdersListScreen({super.key});

  @override
  State<IncomingOrdersListScreen> createState() =>
      _IncomingOrdersListScreenState();
}

class _IncomingOrdersListScreenState extends State<IncomingOrdersListScreen> {
  late Future<List<IncomingOrderModel>> _incomingOrdersFuture;

  @override
  void initState() {
    super.initState();
    _incomingOrdersFuture = DatabaseIncomingOrdersManager().getIncomingOrders();
  }

  void _navigateToAddOrderScreen() async {
    final newOrder = await Navigator.push<IncomingOrderModel>(
      context,
      MaterialPageRoute(builder: (context) => const AddIncomingOrderScreen()),
    );

    if (newOrder != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderDetailScreen(order: newOrder),
        ),
      );
    }

    setState(() {
      _incomingOrdersFuture =
          DatabaseIncomingOrdersManager().getIncomingOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('incomingOrders')),
      ),
      body: FutureBuilder<List<IncomingOrderModel>>(
        future: _incomingOrdersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
                    '${AppLocalizations.of(context).translate('error')}: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text(AppLocalizations.of(context)
                    .translate('noIncomingOrders')));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final order = snapshot.data![index];
                return ListTile(
                  title: Text(order.orderId),
                  subtitle: Text(order.supplierName),
                  trailing: Text(order.orderStatus),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailScreen(order: order),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddOrderScreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}
