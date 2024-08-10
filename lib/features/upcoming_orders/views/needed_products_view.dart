import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/core/widgets/delete_conformation_dialog.dart';
import 'package:pos_dashboard_v1/features/upcoming_orders/database/database_incoming_orders_manager..dart';
import 'package:pos_dashboard_v1/features/upcoming_orders/widgets/needed_products_details.dart';
import 'package:pos_dashboard_v1/features/upcoming_orders/widgets/needed_products_form.dart';
import '../../../l10n/app_localizations.dart';
import '../model/incoming_order_model.dart';

// class NeededProductsView extends StatefulWidget {
//   const NeededProductsView({super.key});

//   @override
//   State<NeededProductsView> createState() => _NeededProductsViewState();
// }

class NeededProductsView extends StatefulWidget {
  const NeededProductsView({super.key});

  @override
  State<NeededProductsView> createState() => _NeededProductsViewState();
}

class _NeededProductsViewState extends State<NeededProductsView> {
  late Future<List<IncomingOrderModel>> _incomingOrdersFuture;
  String? _selectedDate; // Store the selected date

  @override
  void initState() {
    super.initState();
    _incomingOrdersFuture = DatabaseIncomingOrdersManager().getIncomingOrders();
  }

  void showCustomDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(AppLocalizations.of(context).translate('Add a product')),
          content: const NeededProductsForm(),
        );
      },
    );

    if (result == true) {
      _incomingOrdersFuture =
          DatabaseIncomingOrdersManager().getIncomingOrders();
      setState(() {});
    }
  }

  void showProductsDetails(IncomingOrderModel product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: NeededProductsDetails(
            product: product,
          ),
        );
      },
    );
  }

  void showEditDialog(IncomingOrderModel order) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(AppLocalizations.of(context).translate('Edit a product')),
          content: NeededProductsForm(
            order: order,
          ),
        );
      },
    );

    if (result == true) {
      _incomingOrdersFuture =
          DatabaseIncomingOrdersManager().getIncomingOrders();
      setState(() {});
    }
  }

  Future<void> deleteItem(String itemId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return const DeleteConformationDialog();
      },
    );

    if (confirmed == true) {
      await DatabaseIncomingOrdersManager().deleteIncomingOrder(itemId);
      setState(() {
        _incomingOrdersFuture =
            DatabaseIncomingOrdersManager().getIncomingOrders();
      });
    }
  }

  // Function to show date picker and filter orders by date
  void _filterByDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        _incomingOrdersFuture =
            DatabaseIncomingOrdersManager().getOrdersByDay(_selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: AppLocalizations.of(context).translate('NeededProducts'),
          actions: [
            CustomSmallButton(
              icon: Icons.add,
              text: AppLocalizations.of(context).translate('AddAProduc'),
              onTap: () async {
                showCustomDialog(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: _filterByDate, // Trigger the date picker
            ),
          ],
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            child: FutureBuilder<List<IncomingOrderModel>>(
              future: _incomingOrdersFuture,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Error occurred'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No orders found'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final order = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8.0),
                          onTap: () {
                            showProductsDetails(order);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: ColorsManager.backgroundColor,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order ID : ${order.orderId}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      'Supplier : ${order.supplierName}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      'Total Amount : \$${order.totalAmount.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showEditDialog(order);
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: ColorsManager.kPrimaryColor,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        deleteItem(order.id);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

// class _NeededProductsViewState extends State<NeededProductsView> {
//   late Future<List<IncomingOrderModel>> _incomingOrdersFuture;

//   @override
//   void initState() {
//     super.initState();
//     _incomingOrdersFuture = DatabaseIncomingOrdersManager().getIncomingOrders();
//   }

//   void showCustomDialog(BuildContext context) async {
//     final result = await showDialog<bool>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           title: Text(AppLocalizations.of(context).translate('Add a product')),
//           content: const NeededProductsForm(),
//         );
//       },
//     );

//     if (result == true) {
//       _incomingOrdersFuture =
//           DatabaseIncomingOrdersManager().getIncomingOrders();
//       setState(() {});
//     }
//   }

//   void showProductsDetails(IncomingOrderModel product) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: NeededProductsDetails(
//             product: product,
//           ),
//         );
//       },
//     );
//   }

//   void showEditDialog(IncomingOrderModel order) async {
//     final result = await showDialog<bool>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           title: Text(AppLocalizations.of(context).translate('Edit a product')),
//           content: NeededProductsForm(
//             order: order,
//           ),
//         );
//       },
//     );

//     if (result == true) {
//       _incomingOrdersFuture =
//           DatabaseIncomingOrdersManager().getIncomingOrders();
//       setState(() {});
//     }
//   }

//   Future<void> deleteItem(String itemId) async {
//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (BuildContext context) {
//         return const DeleteConformationDialog();
//       },
//     );

//     if (confirmed == true) {
//       await DatabaseIncomingOrdersManager().deleteIncomingOrder(itemId);
//       setState(() {
//         _incomingOrdersFuture =
//             DatabaseIncomingOrdersManager().getIncomingOrders();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CustomAppBar(
//           title: AppLocalizations.of(context).translate('NeededProducts'),
//           actions: [
//             CustomSmallButton(
//               icon: Icons.add,
//               text: AppLocalizations.of(context).translate('AddAProduc'),
//               onTap: () async {
//                 showCustomDialog(context);
//               },
//             ),
//           ],
//         ),
//         Expanded(
//           child: Container(
//             color: Colors.white,
//             margin: const EdgeInsets.all(16),
//             padding: const EdgeInsets.all(16),
//             child: FutureBuilder<List<IncomingOrderModel>>(
//               future: _incomingOrdersFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   return const Center(child: Text(''));
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return const Center(child: Text(''));
//                 } else {
//                   return ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       final order = snapshot.data![index];
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(8.0),
//                           onTap: () {
//                             showProductsDetails(order);
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 8,
//                             ),
//                             decoration: BoxDecoration(
//                               color: ColorsManager.backgroundColor,
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Order ID : ${order.orderId}',
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.w400,
//                                         fontSize: 16.0,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 3),
//                                     Text(
//                                       'Supplier : ${order.supplierName}',
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.w400,
//                                         fontSize: 16.0,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 3),
//                                     Text(
//                                       'Total Amount : \$${order.totalAmount.toStringAsFixed(2)}',
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.w400,
//                                         fontSize: 16.0,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     IconButton(
//                                       onPressed: () {
//                                         showEditDialog(order);
//                                       },
//                                       icon: const Icon(
//                                         Icons.edit,
//                                         color: ColorsManager.kPrimaryColor,
//                                       ),
//                                     ),
//                                     IconButton(
//                                       onPressed: () {
//                                         deleteItem(order.id);
//                                       },
//                                       icon: const Icon(
//                                         Icons.delete,
//                                         color: Colors.red,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
