import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class AddCustomerDialog extends StatefulWidget {
  const AddCustomerDialog({super.key});

  @override
  State<AddCustomerDialog> createState() => _AddCustomerDialogState();
}

class _AddCustomerDialogState extends State<AddCustomerDialog> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _customerData = {
    'fullName': '',
    'indebtedness': '',
    'currentAccount': '',
    'notes': ''
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).translate('addNewCustomer')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
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
                onSaved: (value) => _customerData['fullName'] = value!,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context).translate('indebtedness')),
                onSaved: (value) => _customerData['indebtedness'] = value!,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)
                        .translate('currentAccount')),
                onSaved: (value) => _customerData['currentAccount'] = value!,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).translate('notes')),
                onSaved: (value) => _customerData['notes'] = value!,
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
              Navigator.of(context).pop(_customerData);
            }
          },
          child: Text(AppLocalizations.of(context).translate('add')),
        ),
      ],
    );
  }
}
