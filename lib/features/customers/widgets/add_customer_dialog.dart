import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_button.dart';
import 'package:pos_dashboard_v1/features/customers/database/customers_helper.dart';
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
        width: MediaQuery.of(context).size.width * .5,
        height: MediaQuery.of(context).size.height * .75,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 16),
                buildTextField('name', 'name'),
                buildTextField('phoneNumber', 'phone_number'),
                buildTextField('email', 'emailLabel'),
                buildTextField('address', 'address'),
                buildTextField('notes', 'notes'),
                buildTextField('birthDate', 'birth_date'),
                buildTextField('gender', 'genderLabel'),
                buildTextField('status', 'status'),
                buildTextField('alternativePhone', 'alternative_phone'),
                buildTextField('socialMedia', 'social_media'),
                buildTextField(
                    'preferredPaymentMethod', 'preferred_payment_method'),
                buildTextField('secondaryAddress', 'Secondary Address'),
                buildTextField('postalCode', 'Postal Code'),
                buildTextField('deliveryPreferences', 'Delivery Preferences'),
                buildTextField('customerInterests', 'Customer Interests'),
                buildTextField('supportRating', 'Support Rating'),
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
