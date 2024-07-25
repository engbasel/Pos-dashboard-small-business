import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/catigories/models/ItemModel.dart';
import 'package:pos_dashboard_v1/features/catigories/database/item_database_helper.dart';

import '../../../core/widgets/CustomSnackBar.dart';

class EditItemScreen extends StatefulWidget {
  final ItemModel item;

  const EditItemScreen({super.key, required this.item});

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _skuController;
  late TextEditingController _barcodeController;
  late TextEditingController _purchasePriceController;
  late TextEditingController _salePriceController;
  late TextEditingController _wholesalePriceController;
  late TextEditingController _taxRateController;
  late TextEditingController _quantityController;
  late TextEditingController _alertQuantityController;
  late TextEditingController _imageController;
  late TextEditingController _brandController;
  late TextEditingController _sizeController;
  late TextEditingController _weightController;
  late TextEditingController _colorController;
  late TextEditingController _materialController;
  late TextEditingController _warrantyController;
  late TextEditingController _supplierIdController;
  late TextEditingController _itemStatusController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item.name);
    _descriptionController =
        TextEditingController(text: widget.item.description);
    _skuController = TextEditingController(text: widget.item.sku);
    _barcodeController = TextEditingController(text: widget.item.barcode);
    _purchasePriceController =
        TextEditingController(text: widget.item.purchasePrice?.toString());
    _salePriceController =
        TextEditingController(text: widget.item.salePrice?.toString());
    _wholesalePriceController =
        TextEditingController(text: widget.item.wholesalePrice?.toString());
    _taxRateController =
        TextEditingController(text: widget.item.taxRate?.toString());
    _quantityController =
        TextEditingController(text: widget.item.quantity?.toString());
    _alertQuantityController =
        TextEditingController(text: widget.item.alertQuantity?.toString());
    _imageController = TextEditingController(text: widget.item.image);
    _brandController = TextEditingController(text: widget.item.brand);
    _sizeController = TextEditingController(text: widget.item.size);
    _weightController =
        TextEditingController(text: widget.item.weight?.toString());
    _colorController = TextEditingController(text: widget.item.color);
    _materialController = TextEditingController(text: widget.item.material);
    _warrantyController = TextEditingController(text: widget.item.warranty);
    _supplierIdController =
        TextEditingController(text: widget.item.supplierId?.toString());
    _itemStatusController = TextEditingController(text: widget.item.itemStatus);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _skuController.dispose();
    _barcodeController.dispose();
    _purchasePriceController.dispose();
    _salePriceController.dispose();
    _wholesalePriceController.dispose();
    _taxRateController.dispose();
    _quantityController.dispose();
    _alertQuantityController.dispose();
    _imageController.dispose();
    _brandController.dispose();
    _sizeController.dispose();
    _weightController.dispose();
    _colorController.dispose();
    _materialController.dispose();
    _warrantyController.dispose();
    _supplierIdController.dispose();
    _itemStatusController.dispose();
    super.dispose();
  }

  void _saveChanges() async {
    // Update the item model with new values
    widget.item.name = _nameController.text;
    widget.item.description = _descriptionController.text;
    widget.item.sku = _skuController.text;
    widget.item.barcode = _barcodeController.text;
    widget.item.purchasePrice = double.tryParse(_purchasePriceController.text);
    widget.item.salePrice = double.tryParse(_salePriceController.text);
    widget.item.wholesalePrice =
        double.tryParse(_wholesalePriceController.text);
    widget.item.taxRate = double.tryParse(_taxRateController.text);
    widget.item.quantity = int.tryParse(_quantityController.text);
    widget.item.alertQuantity = int.tryParse(_alertQuantityController.text);
    widget.item.image = _imageController.text;
    widget.item.brand = _brandController.text;
    widget.item.size = _sizeController.text;
    widget.item.weight = double.tryParse(_weightController.text);
    widget.item.color = _colorController.text;
    widget.item.material = _materialController.text;
    widget.item.warranty = _warrantyController.text;
    widget.item.supplierId = int.tryParse(_supplierIdController.text);
    widget.item.itemStatus = _itemStatusController.text;

    // Save the changes to the database
    await ItemDatabaseHelper.instance.updateItem(widget.item);

    // Go back to the previous screen
    Navigator.pop(context, widget.item);
    CustomSnackBar.show(context, 'Massage edited');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Item'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Item Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _skuController,
              decoration: const InputDecoration(labelText: 'SKU'),
            ),
            TextField(
              controller: _barcodeController,
              decoration: const InputDecoration(labelText: 'Barcode'),
            ),
            TextField(
              controller: _purchasePriceController,
              decoration: const InputDecoration(labelText: 'Purchase Price'),
            ),
            TextField(
              controller: _salePriceController,
              decoration: const InputDecoration(labelText: 'Sale Price'),
            ),
            TextField(
              controller: _wholesalePriceController,
              decoration: const InputDecoration(labelText: 'Wholesale Price'),
            ),
            TextField(
              controller: _taxRateController,
              decoration: const InputDecoration(labelText: 'Tax Rate'),
            ),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),
            TextField(
              controller: _alertQuantityController,
              decoration: const InputDecoration(labelText: 'Alert Quantity'),
            ),
            TextField(
              controller: _imageController,
              decoration: const InputDecoration(labelText: 'Image'),
            ),
            TextField(
              controller: _brandController,
              decoration: const InputDecoration(labelText: 'Brand'),
            ),
            TextField(
              controller: _sizeController,
              decoration: const InputDecoration(labelText: 'Size'),
            ),
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(labelText: 'Weight'),
            ),
            TextField(
              controller: _colorController,
              decoration: const InputDecoration(labelText: 'Color'),
            ),
            TextField(
              controller: _materialController,
              decoration: const InputDecoration(labelText: 'Material'),
            ),
            TextField(
              controller: _warrantyController,
              decoration: const InputDecoration(labelText: 'Warranty'),
            ),
            TextField(
              controller: _supplierIdController,
              decoration: const InputDecoration(labelText: 'Supplier ID'),
            ),
            TextField(
              controller: _itemStatusController,
              decoration: const InputDecoration(labelText: 'Item Status'),
            ),
          ],
        ),
      ),
    );
  }
}
