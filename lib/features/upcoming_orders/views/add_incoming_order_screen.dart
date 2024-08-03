import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/features/upcoming_orders/database/database_incoming_orders_manager..dart';
import 'package:pos_dashboard_v1/features/upcoming_orders/views/needed_products_details.dart';
import 'package:pos_dashboard_v1/features/upcoming_orders/views/needed_products_form.dart';
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
                  return const Center(
                    child: Text(''),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final order = snapshot.data![index];
                      return Card(
                        elevation: 2,
                        color: ColorsManager.backgroundColor,
                        margin: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(order.orderId),
                          subtitle: Text(order.supplierName),
                          trailing: Text(order.orderStatus),
                          onTap: () => showProductsDetails(order),
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
