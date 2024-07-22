// import 'package:flutter/material.dart';
// import 'package:pos_dashboard_v1/features/clinet/widgets/EditCustomerDialog.dart';

// class CustomerDetailView extends StatelessWidget {
//   final Map<String, dynamic> customer;
//   final Function(Map<String, String>) onEdit;
//   final Function(int) onDelete;

//   const CustomerDetailView({
//     required this.customer,
//     required this.onEdit,
//     required this.onDelete,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Customer Details'),
//         actions: [
//           IconButton(
//             onPressed: () async {
//               final updatedCustomer = await showDialog<Map<String, String>>(
//                 context: context,
//                 builder: (context) => EditCustomerDialog(customer: customer),
//               );
//               if (updatedCustomer != null) {
//                 onEdit(updatedCustomer);
//                 Navigator.of(context).pop();
//               }
//             },
//             icon: const Icon(Icons.edit),
//             tooltip: 'Edit',
//           ),
//           IconButton(
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) => AlertDialog(
//                   title: const Text('Confirm Delete'),
//                   content: const Text(
//                       'Are you sure you want to delete this customer?'),
//                   actions: <Widget>[
//                     TextButton(
//                       onPressed: () => Navigator.of(context).pop(false),
//                       child: const Text('Cancel'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         onDelete(customer['id']);
//                         Navigator.of(context).pop();
//                         Navigator.of(context).pop();
//                       },
//                       child: const Text('Delete'),
//                     ),
//                   ],
//                 ),
//               );
//             },
//             icon: const Icon(Icons.delete),
//             tooltip: 'Delete',
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Full Name: ${customer['fullName']}',
//                 style: Theme.of(context).textTheme.titleLarge),
//             const SizedBox(height: 8),
//             Text('Indebtedness: ${customer['indebtedness']}'),
//             Text('Current Account: ${customer['currentAccount']}'),
//             Text('Notes: ${customer['notes']}'),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../widgets/EditCustomerDialog.dart';

class CustomerDetailView extends StatelessWidget {
  final Map<String, dynamic> customer;
  final Function(Map<String, String>) onEdit;
  final Function(int) onDelete;

  const CustomerDetailView({
    required this.customer,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Details'),
        actions: [
          IconButton(
            onPressed: () async {
              final updatedCustomer = await showDialog<Map<String, String>>(
                context: context,
                builder: (context) => EditCustomerDialog(customer: customer),
              );
              if (updatedCustomer != null) {
                onEdit(updatedCustomer);
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.edit),
            tooltip: 'Edit',
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Confirm Delete'),
                  content: const Text(
                      'Are you sure you want to delete this customer?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        onDelete(customer['id']);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.delete),
            tooltip: 'Delete',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Full Name: ${customer['fullName']}',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Indebtedness: ${customer['indebtedness']}'),
            Text('Current Account: ${customer['currentAccount']}'),
            Text('Notes: ${customer['notes']}'),
          ],
        ),
      ),
    );
  }
}
