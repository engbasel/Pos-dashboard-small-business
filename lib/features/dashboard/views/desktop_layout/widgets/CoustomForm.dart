import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            controller: dateTimeController,
            labelText: localizations.translate('dateTime'),
            keyboardType: TextInputType.datetime,
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            controller: typeController,
            labelText: localizations.translate('orderType'),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            controller: employeeController,
            labelText: localizations.translate('employee'),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            controller: statusController,
            labelText: localizations.translate('status'),
            keyboardType: TextInputType.text,
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
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
    );
  }
}
