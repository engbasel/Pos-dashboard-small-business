import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/models/order_model.dart';
import 'package:pos_dashboard_v1/features/prodacts/views/products_Item_details_view.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

class OrdersListBody extends StatelessWidget {
  const OrdersListBody({super.key, required this.orders});
  final List<Order> orders;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(),
          DataTable(
            columns: <DataColumn>[
              DataColumn(label: Text(localizations.translate('orderID'))),
              DataColumn(label: Text(localizations.translate('dateTime'))),
              DataColumn(label: Text(localizations.translate('orderType'))),
              DataColumn(label: Text(localizations.translate('employee'))),
              DataColumn(label: Text(localizations.translate('status'))),
              DataColumn(label: Text(localizations.translate('paymentStatus'))),
              DataColumn(label: Text(localizations.translate('amount'))),
              DataColumn(label: Text(localizations.translate('actions'))),
            ],
            rows: List<DataRow>.generate(orders.length, (index) {
              return DataRow(
                cells: [
                  DataCell(
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetailsScreen(
                              order: orders[index],
                            ),
                          ),
                        );
                      },
                      child: Text(orders[index].id),
                    ),
                  ),
                  DataCell(Text(orders[index].dateTime)),
                  DataCell(Text(orders[index].type)),
                  DataCell(Text(orders[index].employee)),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: orders[index].status == 'Complete'
                            ? const Color(0xffE6F6E9)
                            : const Color(0xffFFB074).withOpacity(.15),
                        borderRadius: BorderRadius.circular(19),
                      ),
                      child: Text(
                        orders[index].status,
                        style: TextStyle(
                          color: orders[index].status == 'Complete'
                              ? const Color(0xff2CC56F)
                              : const Color(0xffFF9A00),
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      orders[index].paymentStatus,
                      style: const TextStyle(color: Color(0xff2CC56F)),
                    ),
                  ),
                  DataCell(Text('\$ ${orders[index].amount}')),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Handle edit
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Handle delete
                        },
                      ),
                    ],
                  )),
                ],
              );
            }),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
