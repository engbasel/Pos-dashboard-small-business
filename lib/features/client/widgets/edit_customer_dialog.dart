import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class EditCustomerDialog extends StatefulWidget {
  final Map<String, dynamic> customer;

  const EditCustomerDialog({required this.customer, super.key});

  @override
  State<EditCustomerDialog> createState() => _EditCustomerDialogState();
}

class _EditCustomerDialogState extends State<EditCustomerDialog> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, String> _editedCustomer;

  @override
  void initState() {
    super.initState();
    _editedCustomer = {
      'id': widget.customer['id'].toString(),
      'fullName': widget.customer['fullName'],
      'indebtedness': widget.customer['indebtedness'],
      'currentAccount': widget.customer['currentAccount'],
      'notes': widget.customer['notes'],
    };
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).translate('editCustomer')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: _editedCustomer['fullName'],
                decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context).translate('fullName')),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)
                        .translate('pleaseEnterFullName');
                  }
                  return null;
                },
                onSaved: (value) => _editedCustomer['fullName'] = value!,
              ),
              TextFormField(
                initialValue: _editedCustomer['indebtedness'],
                decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context).translate('indebtedness')),
                onSaved: (value) => _editedCustomer['indebtedness'] = value!,
              ),
              TextFormField(
                initialValue: _editedCustomer['currentAccount'],
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)
                        .translate('currentAccount')),
                onSaved: (value) => _editedCustomer['currentAccount'] = value!,
              ),
              TextFormField(
                initialValue: _editedCustomer['notes'],
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).translate('notes')),
                onSaved: (value) => _editedCustomer['notes'] = value!,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context).translate('cancel')),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              Navigator.of(context).pop(_editedCustomer);
            }
          },
          child: Text(AppLocalizations.of(context).translate('save')),
        ),
      ],
    );
  }
}
