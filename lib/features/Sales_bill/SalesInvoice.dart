import 'package:pos_dashboard_v1/features/Sales_bill/model/SalesItemModel.dart';

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
