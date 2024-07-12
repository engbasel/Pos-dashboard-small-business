import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';

class CoustomForm extends StatelessWidget {
  const CoustomForm({
    super.key,
    required this.idController,
    required this.localizations,
    required this.dateTimeController,
    required this.typeController,
    required this.employeeController,
    required this.statusController,
    required this.paymentMethods,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodChanged,
    required this.amountController,
  });

  final TextEditingController idController;
  final AppLocalizations localizations;
  final TextEditingController dateTimeController;
  final TextEditingController typeController;
  final TextEditingController employeeController;
  final TextEditingController statusController;
  final List<String> paymentMethods;
  final String? selectedPaymentMethod;
  final ValueChanged<String?> onPaymentMethodChanged;
  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: idController,
            labelText: localizations.translate('orderID'),
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
              controller: dateTimeController,
              labelText: localizations.translate('dateTime')),
          const SizedBox(height: 16.0),
          CustomTextField(
            controller: typeController,
            labelText: localizations.translate('orderType'),
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            controller: employeeController,
            labelText: localizations.translate('employee'),
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            controller: statusController,
            labelText: localizations.translate('status'),
          ),
          const SizedBox(height: 16.0),
          DropdownButtonFormField<String>(
            value: selectedPaymentMethod,
            onChanged: onPaymentMethodChanged,
            decoration: InputDecoration(
              labelText: localizations.translate('paymentStatus'),
              border: const OutlineInputBorder(),
            ),
            items: paymentMethods.map((String method) {
              return DropdownMenuItem<String>(
                value: method,
                child: Text(method),
              );
            }).toList(),
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            controller: amountController,
            labelText: localizations.translate('amount'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

Widget CustomTextField({
  required TextEditingController controller,
  required String labelText,
  TextInputType keyboardType = TextInputType.text,
}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
      border: const OutlineInputBorder(),
    ),
    keyboardType: keyboardType,
  );
}
