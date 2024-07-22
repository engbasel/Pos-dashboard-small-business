import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/CoustomTextFormFiled.dart';
import '../../../l10n/app_localizations.dart';

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
          CoustomTextFormFiled(
            controller: idController,
            labelText: localizations.translate('orderID'),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          const SizedBox(height: 16.0),
          CoustomTextFormFiled(
            controller: dateTimeController,
            labelText: localizations.translate('dateTime'),
            keyboardType: TextInputType.datetime,
          ),
          const SizedBox(height: 16.0),
          CoustomTextFormFiled(
            controller: typeController,
            labelText: localizations.translate('orderType'),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          CoustomTextFormFiled(
            controller: employeeController,
            labelText: localizations.translate('employee'),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          CoustomTextFormFiled(
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
          CoustomTextFormFiled(
            controller: amountController,
            labelText: localizations.translate('amount'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
          ),
          const SizedBox(height: 16.0),
          CoustomTextFormFiled(
            controller: numberOfItemsController,
            labelText: localizations.translate('numberOfItems'),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          const SizedBox(height: 16.0),
          CoustomTextFormFiled(
            controller: entryDateController,
            labelText: localizations.translate('entryDate'),
            keyboardType: TextInputType.datetime,
          ),
          const SizedBox(height: 16.0),
          CoustomTextFormFiled(
            controller: exitDateController,
            labelText: localizations.translate('exitDate'),
            keyboardType: TextInputType.datetime,
          ),
          const SizedBox(height: 16.0),
          CoustomTextFormFiled(
            controller: wholesalePriceController,
            labelText: localizations.translate('wholesalePrice'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
          ),
          const SizedBox(height: 16.0),
          CoustomTextFormFiled(
            controller: retailPriceController,
            labelText: localizations.translate('retailPrice'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
          ),
          const SizedBox(height: 16.0),
          CoustomTextFormFiled(
            controller: productStatusController,
            labelText: localizations.translate('productStatus'),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          CoustomTextFormFiled(
            controller: productDetailsController,
            labelText: localizations.translate('productDetails'),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16.0),
          CoustomTextFormFiled(
            controller: productModelController,
            labelText: localizations.translate('productModel'),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
