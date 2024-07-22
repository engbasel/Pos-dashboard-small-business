// import 'package:flutter/material.dart';

// class EditCustomerDialog extends StatefulWidget {
//   final Map<String, dynamic> customer;

//   const EditCustomerDialog({required this.customer, super.key});

//   @override
//   _EditCustomerDialogState createState() => _EditCustomerDialogState();
// }

// class _EditCustomerDialogState extends State<EditCustomerDialog> {
//   final _formKey = GlobalKey<FormState>();
//   late Map<String, String> _customerData;

//   @override
//   void initState() {
//     super.initState();
//     _customerData = Map<String, String>.from(widget.customer);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Edit Customer'),
//       content: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextFormField(
//                 initialValue: _customerData['fullName'],
//                 decoration: const InputDecoration(labelText: 'Full Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter full name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _customerData['fullName'] = value!,
//               ),
//               TextFormField(
//                 initialValue: _customerData['indebtedness'],
//                 decoration: const InputDecoration(labelText: 'Indebtedness'),
//                 onSaved: (value) => _customerData['indebtedness'] = value!,
//               ),
//               TextFormField(
//                 initialValue: _customerData['currentAccount'],
//                 decoration: const InputDecoration(labelText: 'Current Account'),
//                 onSaved: (value) => _customerData['currentAccount'] = value!,
//               ),
//               TextFormField(
//                 initialValue: _customerData['notes'],
//                 decoration: const InputDecoration(labelText: 'Notes'),
//                 onSaved: (value) => _customerData['notes'] = value!,
//               ),
//             ],
//           ),
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: const Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             if (_formKey.currentState!.validate()) {
//               _formKey.currentState!.save();
//               Navigator.of(context).pop(_customerData);
//             }
//           },
//           child: const Text('Save'),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class EditCustomerDialog extends StatefulWidget {
  final Map<String, dynamic> customer;

  const EditCustomerDialog({required this.customer, super.key});

  @override
  _EditCustomerDialogState createState() => _EditCustomerDialogState();
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
      title: const Text('Edit Customer'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: _editedCustomer['fullName'],
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter full name';
                  }
                  return null;
                },
                onSaved: (value) => _editedCustomer['fullName'] = value!,
              ),
              TextFormField(
                initialValue: _editedCustomer['indebtedness'],
                decoration: const InputDecoration(labelText: 'Indebtedness'),
                onSaved: (value) => _editedCustomer['indebtedness'] = value!,
              ),
              TextFormField(
                initialValue: _editedCustomer['currentAccount'],
                decoration: const InputDecoration(labelText: 'Current Account'),
                onSaved: (value) => _editedCustomer['currentAccount'] = value!,
              ),
              TextFormField(
                initialValue: _editedCustomer['notes'],
                decoration: const InputDecoration(labelText: 'Notes'),
                onSaved: (value) => _editedCustomer['notes'] = value!,
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
              Navigator.of(context).pop(_editedCustomer);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
