import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/Manager/manager.dart';
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
  List<Order> filteredOrders = [];
  final SalesDatabaseHelper db = SalesDatabaseHelper.instance;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadSavedInvoices();
    searchController.addListener(() {
      handleSearch(searchController.text);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> loadSavedInvoices() async {
    final loadedOrders = await db.getSalesInvoices();
    setState(() {
      orders = loadedOrders;
      filteredOrders = loadedOrders;
    });
  }

  void handleDelete(int index) async {
    final invoice = filteredOrders[index];
    await SalesDatabaseHelper.deleteInvoice(invoice.invoiceNumber);

    setState(() {
      filteredOrders.removeAt(index);
      orders
          .removeWhere((order) => order.invoiceNumber == invoice.invoiceNumber);
    });
  }

  void handleSearch(String query) {
    setState(() {
      final lowerCaseQuery = query.toLowerCase();
      filteredOrders = orders.where((order) {
        final lowerCaseInvoiceNumber = order.invoiceNumber.toLowerCase();
        final lowerCaseName = order.customerName
            .toLowerCase(); // Assuming the Order model has a 'customerName' field

        return lowerCaseInvoiceNumber.contains(lowerCaseQuery) ||
            lowerCaseName.contains(lowerCaseQuery);
      }).toList();
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
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Material(
            color: Colors.white,
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)
                    .translate('Search_for_a_product'),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorsManager.kPrimaryColor,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorsManager.kPrimaryColor,
                  ),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorsManager.kPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            child: OrdersList(
              orders: filteredOrders,
              onDelete: handleDelete,
            ),
          ),
        ),
      ],
    );
  }
}
