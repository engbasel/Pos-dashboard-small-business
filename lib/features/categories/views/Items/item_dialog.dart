import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/categories/models/item_model.dart';
import 'package:pos_dashboard_v1/features/categories/database/item_database_helper.dart';
import '../../../../l10n/app_localizations.dart';
import 'image_picker_helper.dart';

Future<void> showAddItemDialog(
    BuildContext context, int categoryId, Function loadItems) async {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final skuController = TextEditingController();
  final barcodeController = TextEditingController();
  final purchasePriceController = TextEditingController();
  final salePriceController = TextEditingController();
  final wholesalePriceController = TextEditingController();
  final taxRateController = TextEditingController();
  final quantityController = TextEditingController();
  final alertQuantityController = TextEditingController();
  final imageController = TextEditingController();
  final brandController = TextEditingController();
  final sizeController = TextEditingController();
  final weightController = TextEditingController();
  final colorController = TextEditingController();
  final materialController = TextEditingController();
  final warrantyController = TextEditingController();
  final supplierIdController = TextEditingController();
  String? itemStatus;

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(AppLocalizations.of(context).translate('add_item')),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () async {
                      final path = await pickImage();
                      if (path != null) {
                        imageController.text = path;
                      }
                    },
                    child: Text(
                        AppLocalizations.of(context).translate('select_image')),
                  ),
                  imageController.text.isNotEmpty
                      ? Image.file(File(imageController.text), height: 100)
                      : const Icon(Icons.image, size: 100),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('item_name')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate('name_required');
                      }
                      return null;
                    },
                  ),
                  // Add other fields here...

                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('description')),
                  ),
                  TextFormField(
                    controller: skuController,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate('sku')),
                  ),
                  TextFormField(
                    controller: barcodeController,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate('barcode')),
                  ),
                  TextFormField(
                    controller: purchasePriceController,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('purchase_price')),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate('purchase_price_required');
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: salePriceController,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('sale_price')),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: wholesalePriceController,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('wholesale_price')),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: taxRateController,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate('tax_rate')),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: quantityController,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate('quantity')),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: alertQuantityController,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('alert_quantity')),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: imageController,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate('image')),
                  ),
                  TextFormField(
                    controller: brandController,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate('brand')),
                  ),
                  TextFormField(
                    controller: sizeController,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate('size')),
                  ),
                  TextFormField(
                    controller: weightController,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate('weight')),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: colorController,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate('color')),
                  ),
                  TextFormField(
                    controller: materialController,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate('material')),
                  ),
                  TextFormField(
                    controller: warrantyController,
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate('warranty')),
                  ),
                  TextFormField(
                    controller: supplierIdController,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('supplier_id')),
                    keyboardType: TextInputType.number,
                  ),

                  DropdownButtonFormField<String>(
                    value: itemStatus,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('item_status')),
                    items: ['active', 'inactive', 'discontinued']
                        .map((status) => DropdownMenuItem(
                              value: status,
                              child: Text(AppLocalizations.of(context)
                                  .translate(status)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      itemStatus = value;
                    },
                    validator: (value) {
                      if (value == null) {
                        return AppLocalizations.of(context)
                            .translate('status_required');
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(AppLocalizations.of(context).translate('cancel')),
          ),
          TextButton(
            onPressed: () async {
              if (formKey.currentState?.validate() ?? false) {
                await ItemDatabaseHelper.instance.insertItem(
                  ItemModel(
                    id: null,
                    categoryId: categoryId,
                    name: nameController.text,
                    description: descriptionController.text,
                    sku: skuController.text,
                    barcode: barcodeController.text,
                    price: double.tryParse(purchasePriceController.text) ?? 0.0,
                    unitPrice: double.tryParse(salePriceController.text) ?? 0.0,
                    wholesalePrice:
                        double.tryParse(wholesalePriceController.text) ?? 0.0,
                    taxRate: double.tryParse(taxRateController.text) ?? 0.0,
                    quantity: int.tryParse(quantityController.text) ?? 0,
                    alertQuantity:
                        int.tryParse(alertQuantityController.text) ?? 0,
                    image: imageController.text,
                    brand: brandController.text,
                    size: sizeController.text,
                    weight: double.tryParse(weightController.text) ?? 0.0,
                    color: colorController.text,
                    material: materialController.text,
                    warranty: warrantyController.text,
                    supplierId: int.tryParse(supplierIdController.text) ?? 0,
                    itemStatus: itemStatus ?? 'active',
                  ),
                );
                loadItems();
                Navigator.of(context).pop();
              }
            },
            child: Text(AppLocalizations.of(context).translate('add')),
          ),
        ],
      );
    },
  );
}
