import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final TextEditingController dateController = TextEditingController();
  DateTime? selectedDate;

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
    dateController.dispose();
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
        final lowerCaseName = order.customerName.toLowerCase();
        final matchesQuery = lowerCaseInvoiceNumber.contains(lowerCaseQuery) ||
            lowerCaseName.contains(lowerCaseQuery);

        if (selectedDate != null) {
          final invoiceDate = DateFormat('yyyy-MM-dd').parse(order.invoiceDate);
          final matchesDate = invoiceDate.isAtSameMomentAs(selectedDate!);
          return matchesQuery && matchesDate;
        }

        return matchesQuery;
      }).toList();
    });
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
        handleSearch(searchController.text);
      });
    }
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
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16),
        //   child: Material(
        //     color: Colors.white,
        //     child: Column(
        //       children: [
        //         TextField(
        //           controller: searchController,
        //           decoration: InputDecoration(
        //             hintText: AppLocalizations.of(context)
        //                 .translate('Search_for_a_product'),
        //             focusedBorder: const OutlineInputBorder(
        //               borderSide: BorderSide(
        //                 color: ColorsManager.kPrimaryColor,
        //               ),
        //             ),
        //             enabledBorder: const OutlineInputBorder(
        //               borderSide: BorderSide(
        //                 color: ColorsManager.kPrimaryColor,
        //               ),
        //             ),
        //             border: const OutlineInputBorder(
        //               borderSide: BorderSide(
        //                 color: ColorsManager.kPrimaryColor,
        //               ),
        //             ),
        //           ),
        //         ),
        //         const SizedBox(height: 16),
        //         // TextField(
        //         //   controller: dateController,
        //         //   readOnly: true,
        //         //   decoration: InputDecoration(
        //         //     hintText:
        //         //         AppLocalizations.of(context).translate('Select a date'),
        //         //     suffixIcon: IconButton(
        //         //       icon: const Icon(Icons.calendar_today),
        //         //       onPressed: () => pickDate(context),
        //         //     ),
        //         //     focusedBorder: const OutlineInputBorder(
        //         //       borderSide: BorderSide(
        //         //         color: ColorsManager.kPrimaryColor,
        //         //       ),
        //         //     ),
        //         //     enabledBorder: const OutlineInputBorder(
        //         //       borderSide: BorderSide(
        //         //         color: ColorsManager.kPrimaryColor,
        //         //       ),
        //         //     ),
        //         //     border: const OutlineInputBorder(
        //         //       borderSide: BorderSide(
        //         //         color: ColorsManager.kPrimaryColor,
        //         //       ),
        //         //     ),
        //         //   ),
        //         // ),
        //       ],
        //     ),
        //   ),
        // ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Material(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
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
                const SizedBox(width: 8),
                // IconButton(
                //   icon: const Icon(Icons.filter_list),
                //   onPressed: () => pickDate(context),
                // ),

                Container(
                  decoration: BoxDecoration(
                    color: ColorsManager.kPrimaryColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.filter_list,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      pickDate(context);
                    },
                  ),
                ),
              ],
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
