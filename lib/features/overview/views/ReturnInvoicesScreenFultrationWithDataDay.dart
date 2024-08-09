import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/database/database_return_invoice.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/models/return_invoice_model.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

class ReturnInvoicesScreen extends StatefulWidget {
  const ReturnInvoicesScreen({super.key});

  @override
  _ReturnInvoicesScreenState createState() => _ReturnInvoicesScreenState();
}

class _ReturnInvoicesScreenState extends State<ReturnInvoicesScreen> {
  late Future<List<ReturnInvoiceModel>> _returnInvoicesFuture;
  final DatabaseReturnsInvoice _databaseHelper = DatabaseReturnsInvoice();
  DateTime? _selectedDate;
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _returnInvoicesFuture = _databaseHelper.getReturnInvoices();
  }

  Future<void> pickDate(BuildContext context) async {
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

  List<ReturnInvoiceModel> filterInvoices(List<ReturnInvoiceModel> invoices) {
    if (searchQuery.isEmpty) return invoices;
    return invoices.where((invoice) {
      return invoice.id.toString().contains(searchQuery) ||
          invoice.orderId.toString().contains(searchQuery) ||
          invoice.returnDate.contains(searchQuery) ||
          invoice.employee.contains(searchQuery) ||
          invoice.reason.contains(searchQuery) ||
          invoice.amount.toString().contains(searchQuery) ||
          invoice.totalbackmony.toString().contains(searchQuery);
    }).toList();
  }

  Widget buildInvoiceCard(ReturnInvoiceModel invoice) {
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
              '${AppLocalizations.of(context).translate('invoiceID')}: ${invoice.id}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
                '${AppLocalizations.of(context).translate('orderId')}: ${invoice.orderId}'),
            const SizedBox(height: 4),
            Text(
                '${AppLocalizations.of(context).translate('returnDate')}: ${invoice.returnDate}'),
            const SizedBox(height: 4),
            Text(
                '${AppLocalizations.of(context).translate('employee')}: ${invoice.employee}'),
            const SizedBox(height: 4),
            Text(
                '${AppLocalizations.of(context).translate('reason')}: ${invoice.reason}'),
            const SizedBox(height: 4),
            Text(
                '${AppLocalizations.of(context).translate('amount')}: ${invoice.amount}'),
            const SizedBox(height: 4),
            Text(
                '${AppLocalizations.of(context).translate('Total_Back_Money')}: ${invoice.totalbackmony}'),
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
            ? AppLocalizations.of(context).translate('All_Bills')
            : '${AppLocalizations.of(context).translate('Bills_on')} ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => pickDate(context),
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
                  hintText: AppLocalizations.of(context).translate('search'),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
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
                    return Center(
                        child: Text(
                            '${AppLocalizations.of(context).translate('error')}: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                        child: Text(AppLocalizations.of(context)
                            .translate('No_return_invoices_found')));
                  } else {
                    final filteredInvoices = filterInvoices(snapshot.data!);
                    return ListView.builder(
                      itemCount: filteredInvoices.length,
                      itemBuilder: (context, index) {
                        final invoice = filteredInvoices[index];
                        return buildInvoiceCard(invoice);
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
