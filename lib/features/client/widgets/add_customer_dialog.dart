import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_button.dart';
import 'package:pos_dashboard_v1/features/client/database/CustomersHelper.dart';
import '../../../l10n/app_localizations.dart';

class AddCustomerDialog extends StatefulWidget {
  final CustomersHelper customersHelper;

  const AddCustomerDialog({super.key, required this.customersHelper});

  @override
  State<AddCustomerDialog> createState() => _AddCustomerDialogState();
}

class _AddCustomerDialogState extends State<AddCustomerDialog> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> customerData = {
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
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            print('Form validated');
                            _formKey.currentState!.save();
                            print('Form data saved: $customerData');

                            // Insert the data into the database
                            await widget.customersHelper
                                .insertCustomer(customerData);
                            print('Customer data inserted into the database');

                            Navigator.of(context).pop(customerData);
                            print('Dialog closed with customer data');
                          } else {
                            print('Form validation failed');
                          }
                        },
                      ),
                    ),
                  ],
                ),
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
        onSaved: (value) => customerData[field] = value!,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
      ),
    );
  }
}
