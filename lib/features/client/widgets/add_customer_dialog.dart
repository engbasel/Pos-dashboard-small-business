// import 'package:flutter/material.dart';
// import 'package:pos_dashboard_v1/core/widgets/custom_button.dart';
// import '../../../l10n/app_localizations.dart';

// class AddCustomerDialog extends StatefulWidget {
//   const AddCustomerDialog({super.key});

//   @override
//   State<AddCustomerDialog> createState() => _AddCustomerDialogState();
// }

// class _AddCustomerDialogState extends State<AddCustomerDialog> {
//   final _formKey = GlobalKey<FormState>();
//   final Map<String, String> _customerData = {
//     'name': '', // تم تحديث الحقل ليكون name بدلاً من fullName
//     'indebtedness': '',
//     'currentAccount': '',
//     'notes': ''
//   };

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: Colors.white,
//       title: Text(AppLocalizations.of(context).translate('addNewCustomer')),
//       content: SizedBox(
//         width: MediaQuery.of(context).size.width * .4,
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   decoration: InputDecoration(
//                       border: const OutlineInputBorder(),
//                       labelText: AppLocalizations.of(context)
//                           .translate('name')), // تم تحديث النص
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return AppLocalizations.of(context)
//                           .translate('pleaseEnterName'); // تم تحديث النص
//                     }
//                     return null;
//                   },
//                   onSaved: (value) =>
//                       _customerData['name'] = value!, // تم تحديث الحقل
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   decoration: InputDecoration(
//                       border: const OutlineInputBorder(),
//                       labelText: AppLocalizations.of(context)
//                           .translate('indebtedness')),
//                   onSaved: (value) => _customerData['indebtedness'] = value!,
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   decoration: InputDecoration(
//                       border: const OutlineInputBorder(),
//                       labelText: AppLocalizations.of(context)
//                           .translate('currentAccount')),
//                   onSaved: (value) => _customerData['currentAccount'] = value!,
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   decoration: InputDecoration(
//                       border: const OutlineInputBorder(),
//                       labelText:
//                           AppLocalizations.of(context).translate('notes')),
//                   onSaved: (value) => _customerData['notes'] = value!,
//                 ),
//                 const SizedBox(height: 26),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: CustomButton(
//                         text: AppLocalizations.of(context).translate('cancel'),
//                         onTap: () => Navigator.of(context).pop(),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: CustomButton(
//                         text: AppLocalizations.of(context).translate('add'),
//                         onTap: () {
//                           if (_formKey.currentState!.validate()) {
//                             _formKey.currentState!.save();
//                             Navigator.of(context).pop(_customerData);
//                           }
//                         },
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_button.dart';
import '../../../l10n/app_localizations.dart';

class AddCustomerDialog extends StatefulWidget {
  const AddCustomerDialog({super.key});

  @override
  State<AddCustomerDialog> createState() => _AddCustomerDialogState();
}

class _AddCustomerDialogState extends State<AddCustomerDialog> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _customerData = {
    'name': '',
    'phoneNumber': '',
    'email': '',
    'address': '',
    'notes': '',
    'birthDate': '',
    'gender': '',
    'occupation': '',
    'status': '',
    'alternativePhone': '',
    'socialMedia': '',
    'fax': '',
    'creditLimit': '',
    'totalOutstandingAmount': '',
    'creditRating': '',
    'preferredPaymentMethod': '',
    'secondaryAddress': '',
    'postalCode': '',
    'deliveryPreferences': '',
    'customerInterests': '',
    'customerSatisfactionLevel': '',
    'annualPurchaseVolume': '',
    'complaintCount': '',
    'complaintResolutionHistory': '',
    'supportRating': '',
    'customerDiscount': '',
    'activeOffers': '',
    'responsibleEmployee': '',
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(AppLocalizations.of(context).translate('addNewCustomer')),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * .4,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                buildTextField('name', 'Name'),
                buildTextField('phoneNumber', 'Phone Number'),
                buildTextField('email', 'Email'),
                buildTextField('address', 'Address'),
                buildTextField('notes', 'Notes'),
                buildTextField('birthDate', 'Birth Date'),
                buildTextField('gender', 'Gender'),
                buildTextField('occupation', 'Occupation'),
                buildTextField('status', 'Status'),
                buildTextField('alternativePhone', 'Alternative Phone'),
                buildTextField('socialMedia', 'Social Media'),
                buildTextField('fax', 'Fax'),
                buildTextField('creditLimit', 'Credit Limit'),
                buildTextField(
                    'totalOutstandingAmount', 'Total Outstanding Amount'),
                buildTextField('creditRating', 'Credit Rating'),
                buildTextField(
                    'preferredPaymentMethod', 'Preferred Payment Method'),
                buildTextField('secondaryAddress', 'Secondary Address'),
                buildTextField('postalCode', 'Postal Code'),
                buildTextField('deliveryPreferences', 'Delivery Preferences'),
                buildTextField('customerInterests', 'Customer Interests'),
                buildTextField(
                    'customerSatisfactionLevel', 'Customer Satisfaction Level'),
                buildTextField(
                    'annualPurchaseVolume', 'Annual Purchase Volume'),
                buildTextField('complaintCount', 'Complaint Count'),
                buildTextField('complaintResolutionHistory',
                    'Complaint Resolution History'),
                buildTextField('supportRating', 'Support Rating'),
                buildTextField('customerDiscount', 'Customer Discount'),
                buildTextField('activeOffers', 'Active Offers'),
                buildTextField('responsibleEmployee', 'Responsible Employee'),
                const SizedBox(height: 26),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: AppLocalizations.of(context).translate('cancel'),
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomButton(
                        text: AppLocalizations.of(context).translate('add'),
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Navigator.of(context).pop(_customerData);
                          }
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String field, String labelText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: AppLocalizations.of(context).translate(labelText),
        ),
        onSaved: (value) => _customerData[field] = value!,
      ),
    );
  }
}
