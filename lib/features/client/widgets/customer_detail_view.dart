import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'edit_customer_dialog.dart';

class CustomerDetailView extends StatelessWidget {
  final Map<String, dynamic> customer;
  final Function(Map<String, String>) onEdit;
  final Function(int) onDelete;

  const CustomerDetailView({
    required this.customer,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('customerDetails')),
        actions: [
          IconButton(
            onPressed: () async {
              final updatedCustomer = await showDialog<Map<String, String>>(
                context: context,
                builder: (context) => EditCustomerDialog(customer: customer),
              );
              if (updatedCustomer != null) {
                onEdit(updatedCustomer);
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.edit),
            tooltip: AppLocalizations.of(context).translate('edit'),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(
                      AppLocalizations.of(context).translate('confirmDelete')),
                  content: Text(AppLocalizations.of(context)
                      .translate('deleteConfirmation')),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(
                          AppLocalizations.of(context).translate('cancel')),
                    ),
                    TextButton(
                      onPressed: () {
                        onDelete(customer['id']);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                          AppLocalizations.of(context).translate('delete')),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.delete),
            tooltip: AppLocalizations.of(context).translate('delete'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${AppLocalizations.of(context).translate('fullName')}: ${customer['fullName']}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
                '${AppLocalizations.of(context).translate('indebtedness')}: ${customer['indebtedness']}'),
            Text(
                '${AppLocalizations.of(context).translate('currentAccount')}: ${customer['currentAccount']}'),
            Text(
                '${AppLocalizations.of(context).translate('notes')}: ${customer['notes']}'),
          ],
        ),
      ),
    );
  }
}
