import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/dashboard/views/desktop_layout/models/order_model.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Order List',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children:
                    ['All', 'Monthly', 'Weekly', 'Today'].map((filterOption) {
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
            columns: const <DataColumn>[
              DataColumn(label: Text('Order ID')),
              DataColumn(label: Text('Date/Time')),
              DataColumn(label: Text('Order Type')),
              DataColumn(label: Text('Employee')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Payment Status')),
              DataColumn(label: Text('Amount')),
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
                              order.status,
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
                            order.paymentStatus,
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