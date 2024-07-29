import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../l10n/app_localizations.dart';
import '../../dashboard/widgets/custom_text_form_field.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({
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
    required this.numberOfItemsController, // New field controllers
    required this.entryDateController,
    required this.exitDateController,
    required this.wholesalePriceController,
    required this.retailPriceController,
    required this.productStatusController,
    required this.productDetailsController,
    required this.productModelController,
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

  // New controllers for additional fields
  final TextEditingController numberOfItemsController;
  final TextEditingController entryDateController;
  final TextEditingController exitDateController;
  final TextEditingController wholesalePriceController;
  final TextEditingController retailPriceController;
  final TextEditingController productStatusController;
  final TextEditingController productDetailsController;
  final TextEditingController productModelController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CoustomTextFormFiled(
                  controller: idController,
                  labelText: localizations.translate('orderID'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: CoustomTextFormFiled(
                  controller: dateTimeController,
                  labelText: localizations.translate('dateTime'),
                  keyboardType: TextInputType.datetime,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: CoustomTextFormFiled(
                  controller: typeController,
                  labelText: localizations.translate('orderType'),
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: CoustomTextFormFiled(
                  controller: employeeController,
                  labelText: localizations.translate('employee'),
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: CoustomTextFormFiled(
                  controller: statusController,
                  labelText: localizations.translate('status'),
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: DropdownButtonFormField<String>(
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
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: CoustomTextFormFiled(
                  controller: amountController,
                  labelText: localizations.translate('amount'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: CoustomTextFormFiled(
                  controller: numberOfItemsController,
                  labelText: localizations.translate('numberOfItems'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: CoustomTextFormFiled(
                  controller: entryDateController,
                  labelText: localizations.translate('entryDate'),
                  keyboardType: TextInputType.datetime,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: CoustomTextFormFiled(
                  controller: exitDateController,
                  labelText: localizations.translate('exitDate'),
                  keyboardType: TextInputType.datetime,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: CoustomTextFormFiled(
                  controller: wholesalePriceController,
                  labelText: localizations.translate('wholesalePrice'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: CoustomTextFormFiled(
                  controller: retailPriceController,
                  labelText: localizations.translate('retailPrice'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: CoustomTextFormFiled(
                  controller: productStatusController,
                  labelText: localizations.translate('productStatus'),
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: CoustomTextFormFiled(
                  controller: productModelController,
                  labelText: localizations.translate('productModel'),
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          CoustomTextFormFiled(
            controller: productDetailsController,
            labelText: localizations.translate('productDetails'),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
