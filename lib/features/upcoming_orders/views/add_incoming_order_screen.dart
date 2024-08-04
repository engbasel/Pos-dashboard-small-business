import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/features/upcoming_orders/database/database_incoming_orders_manager..dart';
import 'package:pos_dashboard_v1/features/upcoming_orders/views/needed_products_details.dart';
import 'package:pos_dashboard_v1/features/upcoming_orders/views/needed_products_form.dart';
import 'package:pos_dashboard_v1/features/upcoming_orders/widgets/NoNeededProdact.dart';
import '../../../l10n/app_localizations.dart';
import '../model/incoming_order_model.dart';

class AddIncomingOrderScreen extends StatefulWidget {
  const AddIncomingOrderScreen({super.key});

  @override
  State<AddIncomingOrderScreen> createState() => _AddIncomingOrderScreenState();
}

class _AddIncomingOrderScreenState extends State<AddIncomingOrderScreen> {
  late Future<List<IncomingOrderModel>> _incomingOrdersFuture;

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

  // void removeItem(int ItemID) {}

  void removeItem(String itemId) async {
    await DatabaseIncomingOrdersManager().deleteIncomingOrder(itemId);
    setState(() {
      _incomingOrdersFuture =
          DatabaseIncomingOrdersManager().getIncomingOrders();
    });
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
              text: 'Add A Product',
              onTap: () async {
                showCustomDialog(context);
              },
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
                  return const Center(child: Text(''));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const NoNeededProdact();
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final order = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          showProductsDetails(order);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(
                                    0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    order.orderId,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      removeItem(order.id);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Text('Supplier: ${order.supplierName}'),
                              Text('Order Date: ${order.orderDate}'),
                              Text(
                                  'Expected Delivery: ${order.expectedDeliveryDate}'),
                              Text('Status: ${order.orderStatus}'),
                              Text(
                                  'Total Amount: \$${order.totalAmount.toStringAsFixed(2)}'),
                              const SizedBox(height: 8.0),
                              // Align(
                              //   alignment: Alignment.centerRight,
                              //   child: ElevatedButton(
                              //     onPressed: () => showProductsDetails(order),
                              //     child: const Text('View Details'),
                              //   ),
                              // ),
                            ],
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
