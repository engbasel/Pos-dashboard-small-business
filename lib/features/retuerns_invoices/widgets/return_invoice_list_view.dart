import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/models/return_invoice_model.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/widgets/return_invoice_detail_view.dart';

class ReturnInvoiceListScreen extends StatefulWidget {
  final List<ReturnInvoiceModel> returnInvoices;
  final Function() onUpdateList;
  final Function(String) onDeleteInvoice;

  const ReturnInvoiceListScreen({
    super.key,
    required this.returnInvoices,
    required this.onUpdateList,
    required this.onDeleteInvoice,
  });

  @override
  State<ReturnInvoiceListScreen> createState() =>
      _ReturnInvoiceListScreenState();
}

class _ReturnInvoiceListScreenState extends State<ReturnInvoiceListScreen> {
  late List<ReturnInvoiceModel> _returnInvoices;

  @override
  void initState() {
    super.initState();
    _returnInvoices = List.from(widget.returnInvoices);
  }

  void refreshList() {
    widget.onUpdateList();
    setState(() {
      _returnInvoices = List.from(widget.returnInvoices);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Return Invoices List'),
      ),
      body: ListView.builder(
        itemCount: _returnInvoices.length,
        itemBuilder: (context, index) {
          final returnInvoice = _returnInvoices[index];
          return Dismissible(
            key: Key(returnInvoice.id),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              widget.onDeleteInvoice(returnInvoice.id);
              setState(() {
                _returnInvoices.removeAt(index);
              });
            },
            child: InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReturnInvoiceDetailScreen(
                      returnInvoice: returnInvoice,
                    ),
                  ),
                );
                refreshList(); // Refresh the list after coming back from the detail screen
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                margin:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order ID: ${returnInvoice.orderId}',
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Reason: ${returnInvoice.reason}',
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Amount: \$${returnInvoice.amount.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    Text(
                      'Total Back Money: \$${returnInvoice.totalbackmony.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
