import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/core/widgets/delete_conformation_dialog.dart';
import 'package:pos_dashboard_v1/features/upcoming_orders/database/database_incoming_orders_manager..dart';
import 'package:pos_dashboard_v1/features/upcoming_orders/widgets/add_needed_products.dart';
import 'package:pos_dashboard_v1/features/upcoming_orders/widgets/needed_products_details.dart';
import '../../../l10n/app_localizations.dart';
import '../model/incoming_order_model.dart';

class NeededProductsView extends StatefulWidget {
  const NeededProductsView({super.key});

  @override
  State<NeededProductsView> createState() => _NeededProductsViewState();
}

class _NeededProductsViewState extends State<NeededProductsView> {
  late Future<List<IncomingOrderModel>> incomingOrdersFuture;
  String? selectedDate;
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    incomingOrdersFuture = DatabaseIncomingOrdersManager().getIncomingOrders();

    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text;
      });
    });
  }

  void showCustomDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(AppLocalizations.of(context).translate('Add a product')),
          content: const AddNeededProducts(),
        );
      },
    );

    if (result == true) {
      incomingOrdersFuture =
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
          content: AddNeededProducts(
            order: order,
          ),
        );
      },
    );

    if (result == true) {
      incomingOrdersFuture =
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
        incomingOrdersFuture =
            DatabaseIncomingOrdersManager().getIncomingOrders();
      });
    }
  }

  void filterByDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        incomingOrdersFuture =
            DatabaseIncomingOrdersManager().getOrdersByDay(selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Material(
                    color: Colors.white,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText:
                            AppLocalizations.of(context).translate('search'),
                        prefixIcon: const Icon(Icons.search),
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
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
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
                    onPressed: filterByDate,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: FutureBuilder<List<IncomingOrderModel>>(
              future: incomingOrdersFuture,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Error occurred'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text(''));
                } else {
                  List<IncomingOrderModel> filteredOrders = snapshot.data!
                      .where((order) =>
                          order.orderId
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase()) ||
                          order.supplierName
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase()))
                      .toList();

                  if (filteredOrders.isEmpty) {
                    return const Center(child: Text(''));
                  }

                  return ListView.builder(
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
                      return Container(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: InkWell(
                          onTap: () {
                            showProductsDetails(order);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context).translate('orderId')}: ${order.orderId}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    '${AppLocalizations.of(context).translate('supplier')}: ${order.supplierName}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    '${AppLocalizations.of(context).translate('totalAmount')}: \$${order.totalAmount.toStringAsFixed(2)}',
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
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
