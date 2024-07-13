import 'package:flutter/material.dart';

class EditCustomerDialog extends StatefulWidget {
  final Map<String, dynamic> customer;

  const EditCustomerDialog({required this.customer, super.key});

  @override
  _EditCustomerDialogState createState() => _EditCustomerDialogState();
}

class _EditCustomerDialogState extends State<EditCustomerDialog> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, String> _customerData;

  @override
  void initState() {
    super.initState();
    _customerData = Map<String, String>.from(widget.customer);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Customer'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                initialValue: _customerData['fullName'],
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
                initialValue: _customerData['indebtedness'],
                decoration: const InputDecoration(labelText: 'Indebtedness'),
                onSaved: (value) => _customerData['indebtedness'] = value!,
              ),
              TextFormField(
                initialValue: _customerData['currentAccount'],
                decoration: const InputDecoration(labelText: 'Current Account'),
                onSaved: (value) => _customerData['currentAccount'] = value!,
              ),
              TextFormField(
                initialValue: _customerData['notes'],
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
          child: const Text('Save'),
        ),
      ],
    );
  }
}
