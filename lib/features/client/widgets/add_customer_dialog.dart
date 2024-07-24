import 'package:flutter/material.dart';

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
      title: const Text('Add New Customer'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter full name';
                  }
                  return null;
                },
                onSaved: (value) => _customerData['fullName'] = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Indebtedness'),
                onSaved: (value) => _customerData['indebtedness'] = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Current Account'),
                onSaved: (value) => _customerData['currentAccount'] = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Notes'),
                onSaved: (value) => _customerData['notes'] = value!,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              Navigator.of(context).pop(_customerData);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
