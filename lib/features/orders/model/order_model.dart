import 'package:pos_dashboard_v1/features/orders/model/sales_item_model.dart';

class Order {
  Order({
    required this.customerName,
    required this.invoiceDate,
    required this.invoiceNumber,
    required this.items,
  });

  final String customerName;
  final String invoiceDate;
  final String invoiceNumber;
  final List<SalesItem> items;
}
