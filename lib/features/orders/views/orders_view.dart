import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/features/orders/views/add_order_dialog.dart';
import 'package:pos_dashboard_v1/features/orders/databases/sales_database_helper.dart';
import 'package:pos_dashboard_v1/features/orders/model/order_model.dart';
import 'package:pos_dashboard_v1/features/orders/widgets/orders_list.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  List<Order> orders = [];
  final SalesDatabaseHelper db = SalesDatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    loadSavedInvoices();
  }

  Future<void> loadSavedInvoices() async {
    final loadedOrders = await db.getSalesInvoices();
    setState(() {
      orders = loadedOrders;
    });
  }

  void handleDelete(int index) async {
    final invoice = orders[index];
    await SalesDatabaseHelper.deleteInvoice(invoice.invoiceNumber);

    setState(() {
      orders.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomAppBar(
          title: AppLocalizations.of(context).translate('orders'),
          actions: [
            CustomSmallButton(
              icon: Icons.add,
              onTap: () => showDialog(
                context: context,
                builder: (context) => AddOrderDialog(
                  onSave: loadSavedInvoices,
                ),
              ),
              text: AppLocalizations.of(context).translate('addOrder'),
            ),
          ],
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            child: OrdersList(
              orders: orders,
              onDelete: handleDelete,
            ),
          ),
        ),
      ],
    );
  }
}
