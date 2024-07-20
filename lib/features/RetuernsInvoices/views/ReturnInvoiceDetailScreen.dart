// import 'package:flutter/material.dart';
// import 'package:pos_dashboard_v1/features/RetuernsInvoices/models/ReturnInvoice_model.dart';
// import 'package:pos_dashboard_v1/features/RetuernsInvoices/views/EditReturnInvoiceItemScreen.dart';

// class ReturnInvoiceDetailScreen extends StatelessWidget {
//   final ReturnInvoice returnInvoice;
//   final VoidCallback onUpdate;

//   const ReturnInvoiceDetailScreen({
//     super.key,
//     required this.returnInvoice,
//     required this.onUpdate,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Return Invoice Details'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.edit),
//             onPressed: () async {
//               final updatedInvoice = await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => EditReturnInvoiceItemScreen(
//                     returnInvoice: returnInvoice,
//                     onUpdate: onUpdate,
//                   ),
//                 ),
//               );
//               if (updatedInvoice != null) {
//                 onUpdate(); // Refresh the list if the invoice was updated
//               }
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             buildDetailRow('Invoice ID', returnInvoice.id),
//             buildDetailRow('Order ID', returnInvoice.orderId),
//             buildDetailRow('Total Back Money',
//                 '\$${returnInvoice.totalbackmony.toStringAsFixed(2)}'),
//             buildDetailRow('Return Date', returnInvoice.returnDate),
//             buildDetailRow('Employee', returnInvoice.employee),
//             buildDetailRow('Reason', returnInvoice.reason),
//             buildDetailRow(
//                 'Amount', '\$${returnInvoice.amount.toStringAsFixed(2)}'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
//           Text(value),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/RetuernsInvoices/models/ReturnInvoice_model.dart';
import 'package:pos_dashboard_v1/features/RetuernsInvoices/views/EditReturnInvoiceItemScreen.dart';

class ReturnInvoiceDetailScreen extends StatefulWidget {
  final ReturnInvoice returnInvoice;

  const ReturnInvoiceDetailScreen({
    super.key,
    required this.returnInvoice,
  });

  @override
  _ReturnInvoiceDetailScreenState createState() =>
      _ReturnInvoiceDetailScreenState();
}

class _ReturnInvoiceDetailScreenState extends State<ReturnInvoiceDetailScreen> {
  late ReturnInvoice returnInvoice;

  @override
  void initState() {
    super.initState();
    returnInvoice = widget.returnInvoice;
  }

  void _updateReturnInvoice(ReturnInvoice updatedInvoice) {
    setState(() {
      returnInvoice = updatedInvoice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Return Invoice Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final updatedInvoice = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditReturnInvoiceItemScreen(
                    returnInvoice: returnInvoice,
                    onUpdate: _updateReturnInvoice,
                  ),
                ),
              );
              if (updatedInvoice != null) {
                _updateReturnInvoice(
                    updatedInvoice); // Update the UI with the new data
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDetailRow('Invoice ID', returnInvoice.id),
            buildDetailRow('Order ID', returnInvoice.orderId),
            buildDetailRow('Total Back Money',
                '\$${returnInvoice.totalbackmony.toStringAsFixed(2)}'),
            buildDetailRow('Return Date', returnInvoice.returnDate),
            buildDetailRow('Employee', returnInvoice.employee),
            buildDetailRow('Reason', returnInvoice.reason),
            buildDetailRow(
                'Amount', '\$${returnInvoice.amount.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
