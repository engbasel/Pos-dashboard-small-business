import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/database/database_return_invoice.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/models/return_invoice_model.dart';

class ReturnInvoicesScreen extends StatefulWidget {
  const ReturnInvoicesScreen({super.key});

  @override
  _ReturnInvoicesScreenState createState() => _ReturnInvoicesScreenState();
}

class _ReturnInvoicesScreenState extends State<ReturnInvoicesScreen> {
  late Future<List<ReturnInvoiceModel>> _returnInvoicesFuture;
  final DatabaseReturnsInvoice _databaseHelper = DatabaseReturnsInvoice();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _returnInvoicesFuture = _databaseHelper.getReturnInvoices();
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _returnInvoicesFuture = _databaseHelper.getInvoicesByDay(
          DateFormat('yyyy-MM-dd').format(_selectedDate!),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Return Invoices'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _pickDate(context),
          ),
        ],
      ),
      body: FutureBuilder<List<ReturnInvoiceModel>>(
        future: _returnInvoicesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No return invoices found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final invoice = snapshot.data![index];
                return ListTile(
                  title: Text('Invoice ID: ${invoice.id}'),
                  subtitle: Text(
                    'Order ID: ${invoice.orderId}\n'
                    'Return Date: ${invoice.returnDate}\n'
                    'Employee: ${invoice.employee}\n'
                    'Reason: ${invoice.reason}\n'
                    'Amount: ${invoice.amount}\n'
                    'Total Back Money: ${invoice.totalbackmony}',
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
