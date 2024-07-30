import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/sales_bill/databases/sales_database_helper.dart';
import 'package:pos_dashboard_v1/features/sales_bill/model/sales_invoice.dart';

class SalesInvoicesReportScreen extends StatefulWidget {
  const SalesInvoicesReportScreen({super.key});

  @override
  _SalesInvoicesReportScreenState createState() =>
      _SalesInvoicesReportScreenState();
}

class _SalesInvoicesReportScreenState extends State<SalesInvoicesReportScreen> {
  List<SalesInvoice> invoices = [];

  @override
  void initState() {
    super.initState();
    _loadInvoices();
  }

  Future<void> _loadInvoices() async {
    final loadedInvoices =
        await SalesDatabaseHelper.instance.getSalesInvoices();
    setState(() {
      invoices = loadedInvoices;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: invoices.length,
        itemBuilder: (context, index) {
          final invoice = invoices[index];
          return ListTile(
            title: Text('فاتورة رقم: ${invoice.invoiceNumber}'),
            subtitle: Text('العميل: ${invoice.customerName}'),
            trailing: Text('التاريخ: ${invoice.invoiceDate}'),
            onTap: () {
              // You can navigate to a detailed view of the invoice here if needed
            },
          );
        },
      ),
    );
  }
}
