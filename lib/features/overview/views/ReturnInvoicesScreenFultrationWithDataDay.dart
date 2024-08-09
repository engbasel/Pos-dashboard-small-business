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
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

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

  List<ReturnInvoiceModel> _filterInvoices(List<ReturnInvoiceModel> invoices) {
    if (_searchQuery.isEmpty) return invoices;
    return invoices.where((invoice) {
      return invoice.id.toString().contains(_searchQuery) ||
          invoice.orderId.toString().contains(_searchQuery) ||
          invoice.returnDate.contains(_searchQuery) ||
          invoice.employee.contains(_searchQuery) ||
          invoice.reason.contains(_searchQuery) ||
          invoice.amount.toString().contains(_searchQuery) ||
          invoice.totalbackmony.toString().contains(_searchQuery);
    }).toList();
  }

  Widget _buildInvoiceCard(ReturnInvoiceModel invoice) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Invoice ID: ${invoice.id}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text('Order ID: ${invoice.orderId}'),
            const SizedBox(height: 4),
            Text('Return Date: ${invoice.returnDate}'),
            const SizedBox(height: 4),
            Text('Employee: ${invoice.employee}'),
            const SizedBox(height: 4),
            Text('Reason: ${invoice.reason}'),
            const SizedBox(height: 4),
            Text('Amount: ${invoice.amount}'),
            const SizedBox(height: 4),
            Text('Total Back Money: ${invoice.totalbackmony}'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedDate == null
            ? 'All Bills'
            : 'Bills on ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _pickDate(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            Expanded(
              child: FutureBuilder<List<ReturnInvoiceModel>>(
                future: _returnInvoicesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No return invoices found.'));
                  } else {
                    final filteredInvoices = _filterInvoices(snapshot.data!);
                    return ListView.builder(
                      itemCount: filteredInvoices.length,
                      itemBuilder: (context, index) {
                        final invoice = filteredInvoices[index];
                        return _buildInvoiceCard(invoice);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
