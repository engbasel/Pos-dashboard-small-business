import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/features/authentication/database/AuthService.dart';
import 'package:pos_dashboard_v1/features/authentication/models/createAccounts.dart';
import 'package:pos_dashboard_v1/features/categories/database/item_database_helper.dart';
import 'package:pos_dashboard_v1/features/categories/models/item_model.dart';
import 'package:pos_dashboard_v1/features/orders/databases/sales_database_helper.dart';
import 'package:pos_dashboard_v1/features/orders/model/order_model.dart';
import 'package:pos_dashboard_v1/features/notifications/view/notification_view.dart';
import 'package:pos_dashboard_v1/features/orders/views/add_order_dialog.dart';
import 'package:pos_dashboard_v1/features/orders/widgets/order_details.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/profile_dialog.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/user_info_section.dart';
import '../../../l10n/app_localizations.dart';

class OverviewView extends StatefulWidget {
  const OverviewView({super.key});

  @override
  State<OverviewView> createState() => _OverviewViewState();
}

class _OverviewViewState extends State<OverviewView> {
  late Future<List<ItemModel>> itemsBelowAlertQuantity;
  late Future<List<Order>> todayOrders;
  int? itemsNum;
  AuthService authService = AuthService();
  List<Account> users = [];
  late final SalesDatabaseHelper salesDatabaseHelper;

  @override
  void initState() {
    super.initState();
    salesDatabaseHelper = SalesDatabaseHelper.instance;
    loadUserData();
    itemsBelowAlertQuantity = _fetchItemsBelowAlertQuantity();
    todayOrders = salesDatabaseHelper.getTodayInvoices();

    _fetchItemsBelowAlertQuantity().then((items) {
      setState(() {
        itemsBelowAlertQuantity = Future.value(items);
        itemsNum = items.length;
      });
    });
  }
  //

  void loadUserData() async {
    users = await authService.getAllAccounts();
    setState(() {});
  }

  Future<List<ItemModel>> _fetchItemsBelowAlertQuantity() async {
    final dbHelper = ItemDatabaseHelper.instance;
    return await dbHelper.getItemsBelowAlertQuantity();
  }

  void _showOrderDetails(Order order) {
    showDialog(
      context: context,
      builder: (context) => OrderDetails(invoice: order),
    );
  }

  void _showAddOrderDialog() {
    showDialog(
      context: context,
      builder: (context) => AddOrderDialog(
        onSave: () {
          setState(() {
            todayOrders = salesDatabaseHelper.getTodayInvoices();
          });
        },
      ),
    );
  }

  Widget _buildOrderTable(List<Order> orders) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text(
              AppLocalizations.of(context).translate('InvoiceNumber'),
            ),
          ),
          DataColumn(
            label: Text(
              AppLocalizations.of(context).translate('CustomerName'),
            ),
          ),
          DataColumn(
            label: Text(
              AppLocalizations.of(context).translate('InvoiceDate'),
            ),
          ),
          DataColumn(
            label: Text(
              AppLocalizations.of(context).translate('TotalAmount'),
            ),
          ),
          DataColumn(
            label: Text(
              AppLocalizations.of(context).translate('Tax'),
            ),
          ),
          DataColumn(
            label: Text(
              AppLocalizations.of(context).translate('Action'),
            ),
          ),
        ],
        rows: orders.map((order) {
          return DataRow(
            cells: [
              DataCell(Text(order.invoiceNumber.toString())),
              DataCell(Text(order.customerName)),
              DataCell(Text(order.invoiceDate)),
              DataCell(
                Text(
                  '\$${order.items.fold(0.0, (sum, item) => sum + item.total)}',
                ),
              ),
              const DataCell(Text('\$20')),
              DataCell(
                IconButton(
                  icon: const Icon(Icons.details),
                  onPressed: () => _showOrderDetails(order),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppBar(
          title: AppLocalizations.of(context).translate('dashboard'),
          actions: [
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  barrierColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return const NotificationPopup();
                  },
                );
              },
              child: const Icon(
                Icons.notifications_none_outlined,
                color: Color(0xff505251),
              ),
            ),
            const SizedBox(width: 16),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  barrierColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return ProfileDialog(users: users);
                  },
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    users.isEmpty ? '' : '${users[users.length - 1].name}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.keyboard_arrow_down_outlined),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UserInfoSection(),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context).translate('orders'),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CustomSmallButton(
                          icon: Icons.add,
                          onTap: _showAddOrderDialog,
                          text: AppLocalizations.of(context)
                              .translate('addOrder'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    FutureBuilder<List<Order>>(
                      future: todayOrders,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(
                              child: Text(AppLocalizations.of(context)
                                  .translate('No_orders_for_today')));
                        } else {
                          return _buildOrderTable(snapshot.data!);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
