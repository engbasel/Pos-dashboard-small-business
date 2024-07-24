import 'package:pos_dashboard_v1/features/salesBill/model/sales_item_model.dart';

class SalesInvoice {
  SalesInvoice({
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
