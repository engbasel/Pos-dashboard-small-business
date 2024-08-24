import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_button.dart';
import 'package:pos_dashboard_v1/features/upcoming_orders/database/database_incoming_orders_manager..dart';
import '../../../l10n/app_localizations.dart';
import '../model/incoming_order_model.dart';

class AddNeededProducts extends StatefulWidget {
  final IncomingOrderModel? order;

  const AddNeededProducts({super.key, this.order});

  @override
  State<AddNeededProducts> createState() => _AddNeededProductsState();
}

class _AddNeededProductsState extends State<AddNeededProducts> {
  final _formKey = GlobalKey<FormState>();

  final _orderIdController = TextEditingController();
  final _supplierNameController = TextEditingController();
  final _totalAmountController = TextEditingController();

  DateTime? _orderDate;
  DateTime? _expectedDeliveryDate;

  @override
  void initState() {
    super.initState();
    if (widget.order != null) {
      _orderIdController.text = widget.order!.orderId;
      _supplierNameController.text = widget.order!.supplierName;
      _orderDate = DateTime.parse(widget.order!.orderDate);
      _expectedDeliveryDate =
          DateTime.parse(widget.order!.expectedDeliveryDate);
      _totalAmountController.text = widget.order!.totalAmount.toString();
    }
  }

  @override
  void dispose() {
    _orderIdController.dispose();
    _supplierNameController.dispose();
    _totalAmountController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, DateTime? initialDate,
      ValueChanged<DateTime?> onDateSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != initialDate) {
      onDateSelected(picked);
    }
  }

  Future<void> saveForm() async {
    if (_formKey.currentState!.validate()) {
      final order = IncomingOrderModel(
        id: widget.order?.id ?? DateTime.now().toString(),
        orderId: _orderIdController.text,
        supplierName: _supplierNameController.text,
        orderDate: _orderDate!.toIso8601String(),
        expectedDeliveryDate: _expectedDeliveryDate!.toIso8601String(),
        orderStatus: widget.order?.orderStatus ?? 'Pending',
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
              GestureDetector(
                onTap: () => _selectDate(context, _orderDate, (date) {
                  setState(() {
                    _orderDate = date;
                  });
                }),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText:
                          AppLocalizations.of(context).translate('orderDate'),
                      suffixIcon: const Icon(Icons.calendar_month_outlined),
                    ),
                    controller: TextEditingController(
                      text: _orderDate != null
                          ? '${_orderDate!.year}-${_orderDate!.month.toString().padLeft(2, '0')}-${_orderDate!.day.toString().padLeft(2, '0')}'
                          : '',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select order date';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () =>
                    _selectDate(context, _expectedDeliveryDate, (date) {
                  setState(() {
                    _expectedDeliveryDate = date;
                  });
                }),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: AppLocalizations.of(context)
                          .translate('expectedDeliveryDate'),
                      suffixIcon: const Icon(Icons.calendar_month_outlined),
                    ),
                    controller: TextEditingController(
                      text: _expectedDeliveryDate != null
                          ? '${_expectedDeliveryDate!.year}-${_expectedDeliveryDate!.month.toString().padLeft(2, '0')}-${_expectedDeliveryDate!.day.toString().padLeft(2, '0')}'
                          : '',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select expected delivery date';
                      }
                      return null;
                    },
                  ),
                ),
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
