import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/dashboard/views/desktop_layout/models/order_model.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

class OrderList extends StatefulWidget {
  final List<Order> orders = [
    Order(
        '01015', '10:00 PM', 'Regular', 'Masud Rana', 'Complete', 'Paid', 250),
    Order('01016', '17 May 2022', 'Regular', 'Masud Rana', 'Pending', 'Paid',
        250),
    Order('01017', '17 May 2022', 'Regular', 'Masud Rana', 'Complete', 'Paid',
        250),
    Order('01018', '17 May 2022', 'Regular', 'Masud Rana', 'Complete', 'Paid',
        250),
  ];

  OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  String filter = 'All';

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localizations.translate('orderList'),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  localizations.translate('all'),
                  localizations.translate('monthly'),
                  localizations.translate('weekly'),
                  localizations.translate('today'),
                ].map((filterOption) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          filter = filterOption;
                        });
                      },
                      child: Text(
                        filterOption,
                        style: TextStyle(
                          fontSize: 16,
                          color: filter == filterOption
                              ? const Color(0xff2CC56F)
                              : const Color(0xff37474F).withOpacity(.7),
                          fontWeight: filter == filterOption
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          child: DataTable(
            columns: <DataColumn>[
              DataColumn(label: Text(localizations.translate('orderId'))),
              DataColumn(label: Text(localizations.translate('dateTime'))),
              DataColumn(label: Text(localizations.translate('orderType'))),
              DataColumn(label: Text(localizations.translate('employee'))),
              DataColumn(label: Text(localizations.translate('status'))),
              DataColumn(label: Text(localizations.translate('paymentStatus'))),
              DataColumn(label: Text(localizations.translate('amount'))),
            ],
            rows: widget.orders
                .map((order) => DataRow(
                      cells: [
                        DataCell(Text(order.id)),
                        DataCell(Text(order.dateTime)),
                        DataCell(Text(order.type)),
                        DataCell(Text(order.employee)),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: order.status == 'Complete'
                                  ? const Color(0xffE6F6E9)
                                  : const Color(0xffFFB074).withOpacity(.15),
                              borderRadius: BorderRadius.circular(19),
                            ),
                            child: Text(
                              localizations.translate(order.status),
                              style: TextStyle(
                                color: order.status == 'Complete'
                                    ? const Color(0xff2CC56F)
                                    : const Color(0xffFF9A00),
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            localizations.translate(order.paymentStatus),
                            style: const TextStyle(color: Color(0xff2CC56F)),
                          ),
                        ),
                        DataCell(Text('\$ ${order.amount}')),
                      ],
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
