import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_small_button.dart';
import 'package:pos_dashboard_v1/core/widgets/delete_conformation_dialog.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/database/database_return_invoice.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/models/return_invoice_model.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/widgets/edit_return_invoice_item_view.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/widgets/return_invoice_detail_view.dart';
import 'package:pos_dashboard_v1/features/retuerns_invoices/widgets/return_invoicee_form.dart';
import '../../../l10n/app_localizations.dart';

class ReturnInvoiceScreen extends StatefulWidget {
  const ReturnInvoiceScreen({super.key});

  @override
  State<ReturnInvoiceScreen> createState() => _ReturnInvoiceScreenState();
}

class _ReturnInvoiceScreenState extends State<ReturnInvoiceScreen> {
  final DatabaseReturnsInvoice databaseHelper = DatabaseReturnsInvoice();
  List<ReturnInvoiceModel> returnInvoices = [];
  DateTime? _selectedDate;
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadReturnInvoices();
  }

  Future<void> loadReturnInvoices() async {
    final loadedInvoices = await databaseHelper.getReturnInvoices();
    setState(() {
      returnInvoices = loadedInvoices;
    });
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
        loadReturnInvoicesByDate();
      });
    }
  }

  Future<void> loadReturnInvoicesByDate() async {
    final loadedInvoices = await databaseHelper.getInvoicesByDay(
      DateFormat('yyyy-MM-dd').format(_selectedDate!),
    );
    setState(() {
      returnInvoices = loadedInvoices;
    });
  }

  List<ReturnInvoiceModel> filterInvoices(List<ReturnInvoiceModel> invoices) {
    if (searchQuery.isEmpty) return invoices;
    return invoices.where((invoice) {
      return invoice.id.toString().contains(searchQuery) ||
          invoice.orderId.toString().contains(searchQuery) ||
          invoice.employee.contains(searchQuery);
    }).toList();
  }

  void showAddReturnInvoiceForm(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            AppLocalizations.of(context).translate('addReturn'),
          ),
          content: const ReturnInvoiceeForm(),
        );
      },
    );

    if (result == true) {
      loadReturnInvoices();
    }
  }

  Future<void> deleteItem(ReturnInvoiceModel invoice) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return const DeleteConformationDialog();
      },
    );

    if (confirmed == true) {
      await databaseHelper.deleteReturnInvoice(invoice.id);
      loadReturnInvoices();
    }
  }

  void navigateToReturnInvoiceDetailScreen(ReturnInvoiceModel invoice) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ReturnInvoiceDetailScreen(
            returnInvoice: invoice,
          ),
        );
      },
    );
  }

  void navigateToEditReturnInvoiceItemScreen(ReturnInvoiceModel invoice) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return EditReturnInvoiceItemDialog(
          returnInvoice: invoice,
          onUpdate: (updatedInvoice) {
            setState(() {
              final index = returnInvoices
                  .indexWhere((inv) => inv.id == updatedInvoice.id);
              if (index != -1) {
                returnInvoices[index] = updatedInvoice;
              }
            });
          },
        );
      },
    );

    if (result == true) {
      loadReturnInvoices();
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredInvoices = filterInvoices(returnInvoices);

    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(
            title: AppLocalizations.of(context).translate('returnInvoices'),
            actions: [
              CustomSmallButton(
                icon: Icons.add,
                text: AppLocalizations.of(context).translate('addReturn'),
                onTap: () => showAddReturnInvoiceForm(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Material(
                    color: Colors.white,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText:
                            AppLocalizations.of(context).translate('search'),
                        prefixIcon: const Icon(Icons.search),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorsManager.kPrimaryColor,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorsManager.kPrimaryColor,
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorsManager.kPrimaryColor,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  decoration: BoxDecoration(
                    color: ColorsManager.kPrimaryColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.filter_list,
                      color: Colors.white,
                    ),
                    onPressed: () => pickDate(context),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ...filteredInvoices.map(
            (invoice) => Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: InkWell(
                onTap: () => navigateToReturnInvoiceDetailScreen(invoice),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${AppLocalizations.of(context).translate('orderId')}: ${invoice.orderId}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${AppLocalizations.of(context).translate('employee')}: ${invoice.employee}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${AppLocalizations.of(context).translate('amount')}: ${invoice.amount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () =>
                              navigateToEditReturnInvoiceItemScreen(invoice),
                          icon: const Icon(
                            Icons.edit,
                            color: ColorsManager.kPrimaryColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () => deleteItem(invoice),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
