import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/orders/model/sales_item_model.dart';

class EditItemDialog extends StatefulWidget {
  final SalesItem item;
  final Function(SalesItem) onSave;

  const EditItemDialog({
    super.key,
    required this.item,
    required this.onSave,
  });

  @override
  State<EditItemDialog> createState() => _EditItemDialogState();
}

class _EditItemDialogState extends State<EditItemDialog> {
  late TextEditingController nameController;
  late TextEditingController quantityController;
  late TextEditingController unitPriceController;
  late TextEditingController discountController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.item.name);
    quantityController =
        TextEditingController(text: widget.item.quantity.toString());
    unitPriceController =
        TextEditingController(text: widget.item.unitPrice.toString());
    discountController =
        TextEditingController(text: widget.item.discount.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            readOnly: true,
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: quantityController,
            decoration: const InputDecoration(labelText: 'Quantity'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: unitPriceController,
            decoration: const InputDecoration(labelText: 'Unit Price'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: discountController,
            decoration: const InputDecoration(labelText: 'Discount'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final updatedItem = SalesItem(
              nameController.text,
              int.parse(quantityController.text),
              double.parse(unitPriceController.text),
              double.parse(discountController.text),
              widget.item.itemID,
            );
            widget.onSave(updatedItem);
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
