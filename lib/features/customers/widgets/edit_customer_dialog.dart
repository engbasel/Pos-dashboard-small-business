import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_button.dart';
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
      backgroundColor: Colors.white,
      title: Text(AppLocalizations.of(context).translate('editCustomer')),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * .4,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _editedCustomer['fullName'],
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText:
                        AppLocalizations.of(context).translate('fullName'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)
                          .translate('pleaseEnterFullName');
                    }
                    return null;
                  },
                  onSaved: (value) => _editedCustomer['fullName'] = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _editedCustomer['indebtedness'],
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText:
                        AppLocalizations.of(context).translate('indebtedness'),
                  ),
                  onSaved: (value) => _editedCustomer['indebtedness'] = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _editedCustomer['currentAccount'],
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: AppLocalizations.of(context)
                        .translate('currentAccount'),
                  ),
                  onSaved: (value) =>
                      _editedCustomer['currentAccount'] = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _editedCustomer['notes'],
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: AppLocalizations.of(context).translate('notes'),
                  ),
                  onSaved: (value) => _editedCustomer['notes'] = value!,
                ),
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
                        text: AppLocalizations.of(context).translate('save'),
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Navigator.of(context).pop(_editedCustomer);
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
}
