import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_button.dart';
import 'package:pos_dashboard_v1/features/upcoming_orders/database/database_incoming_orders_manager..dart';
import '../../../l10n/app_localizations.dart';
import '../model/incoming_order_model.dart';

class NeededProductsForm extends StatefulWidget {
  final IncomingOrderModel? order;

  const NeededProductsForm({super.key, this.order});

  @override
  State<NeededProductsForm> createState() => _NeededProductsFormState();
}

class _NeededProductsFormState extends State<NeededProductsForm> {
  final _formKey = GlobalKey<FormState>();

  final _orderIdController = TextEditingController();
  final _supplierNameController = TextEditingController();
  final _orderDateController = TextEditingController();
  final _expectedDeliveryDateController = TextEditingController();
  final _orderStatusController = TextEditingController();
  final _totalAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.order != null) {
      _orderIdController.text = widget.order!.orderId;
      _supplierNameController.text = widget.order!.supplierName;
      _orderDateController.text = widget.order!.orderDate;
      _expectedDeliveryDateController.text = widget.order!.expectedDeliveryDate;
      _orderStatusController.text = widget.order!.orderStatus;
      _totalAmountController.text = widget.order!.totalAmount.toString();
    }
  }

  @override
  void dispose() {
    _orderIdController.dispose();
    _supplierNameController.dispose();
    _orderDateController.dispose();
    _expectedDeliveryDateController.dispose();
    _orderStatusController.dispose();
    _totalAmountController.dispose();
    super.dispose();
  }

  Future<void> saveForm() async {
    if (_formKey.currentState!.validate()) {
      final order = IncomingOrderModel(
        id: widget.order?.id ?? DateTime.now().toString(),
        orderId: _orderIdController.text,
        supplierName: _supplierNameController.text,
        orderDate: _orderDateController.text,
        expectedDeliveryDate: _expectedDeliveryDateController.text,
        orderStatus: _orderStatusController.text,
        totalAmount: double.parse(_totalAmountController.text),
      );

      if (widget.order == null) {
        await DatabaseIncomingOrdersManager().insertIncomingOrder(order);
      } else {
        await DatabaseIncomingOrdersManager().updateIncomingOrder(order);
      }

      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .5,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              TextFormField(
                controller: _orderIdController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: AppLocalizations.of(context).translate('orderId'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter order ID';
                  }
                  final number = num.tryParse(value);
                  if (number == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _supplierNameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText:
                      AppLocalizations.of(context).translate('supplierName'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter supplier name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _orderDateController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText:
                      AppLocalizations.of(context).translate('orderDate'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter order date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _expectedDeliveryDateController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: AppLocalizations.of(context)
                      .translate('expectedDeliveryDate'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter expected delivery date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _orderStatusController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText:
                      AppLocalizations.of(context).translate('orderStatus'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter order status';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _totalAmountController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText:
                      AppLocalizations.of(context).translate('totalAmount'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter total amount';
                  }
                  final number = num.tryParse(value);
                  if (number == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
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
                      text: AppLocalizations.of(context).translate('add'),
                      onTap: saveForm,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
