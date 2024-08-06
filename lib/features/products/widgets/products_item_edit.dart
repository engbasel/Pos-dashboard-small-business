import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/image_picker_helper.dart';
import 'package:pos_dashboard_v1/features/categories/models/item_model.dart';
import 'package:pos_dashboard_v1/features/categories/database/item_database_helper.dart';
import '../../../../../l10n/app_localizations.dart';

Future<void> showEditProductsItemDialog(
    BuildContext context, ItemModel item, Function loadItems) async {
  final formKey = GlobalKey<FormState>();
  final controllers = {
    'name': TextEditingController(text: item.name),
    'description': TextEditingController(text: item.description),
    'sku': TextEditingController(text: item.sku),
    'barcode': TextEditingController(text: item.barcode),
    'purchasePrice': TextEditingController(text: item.price?.toString() ?? ''),
    'salePrice': TextEditingController(text: item.unitPrice?.toString() ?? ''),
    'wholesalePrice':
        TextEditingController(text: item.wholesalePrice?.toString() ?? ''),
    'taxRate': TextEditingController(text: item.taxRate?.toString() ?? ''),
    'quantity': TextEditingController(text: item.quantity?.toString() ?? ''),
    'alertQuantity':
        TextEditingController(text: item.alertQuantity?.toString() ?? ''),
    'image': TextEditingController(text: item.image),
    'brand': TextEditingController(text: item.brand),
    'size': TextEditingController(text: item.size),
    'weight': TextEditingController(text: item.weight?.toString() ?? ''),
    'color': TextEditingController(text: item.color),
    'material': TextEditingController(text: item.material),
    'warranty': TextEditingController(text: item.warranty),
    'supplierId':
        TextEditingController(text: item.supplierId?.toString() ?? ''),
  };
  String? itemStatus = item.itemStatus;
  String? path;

  Widget buildTextField(String key, String label,
      {bool isNumber = false, bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controllers[key],
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).translate(label),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        validator: isRequired
            ? (value) {
                if (value == null || value.isEmpty) {
                  return '${AppLocalizations.of(context).translate(label)} is required';
                }
                return null;
              }
            : null,
      ),
    );
  }

  Widget buildDateField(String key, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () => _selectDate(context, controllers[key]!),
        child: AbsorbPointer(
          child: TextFormField(
            controller: controllers[key],
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).translate(label),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              suffixIcon: const Icon(Icons.calendar_today),
            ),
          ),
        ),
      ),
    );
  }

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(AppLocalizations.of(context).translate('edit_item')),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * .7,
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          path = await pickImage();
                          if (path != null) {
                            setState(() {
                              path = path!;
                            });
                          }
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: path != null
                              ? Image.file(
                                  File(path!),
                                  fit: BoxFit.cover,
                                )
                              : Icon(
                                  Icons.add_a_photo,
                                  color: Colors.grey[800],
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      buildTextField('name', 'item_name', isRequired: true),
                      buildTextField('description', 'description'),
                      buildTextField('sku', 'sku'),
                      buildTextField('barcode', 'barcode'),
                      buildTextField('purchasePrice', 'purchase_price',
                          isNumber: true, isRequired: true),
                      buildTextField('salePrice', 'sale_price', isNumber: true),
                      buildTextField('wholesalePrice', 'wholesale_price',
                          isNumber: true),
                      buildTextField('taxRate', 'tax_rate', isNumber: true),
                      buildTextField('quantity', 'quantity', isNumber: true),
                      buildTextField('alertQuantity', 'alert_quantity',
                          isNumber: true),
                      buildTextField('brand', 'brand'),
                      buildTextField('size', 'size'),
                      buildTextField('weight', 'weight', isNumber: true),
                      buildTextField('color', 'color'),
                      buildTextField('material', 'material'),
                      buildTextField('warranty', 'warranty'),
                      buildTextField('supplierId', 'supplier_id',
                          isNumber: true),
                      DropdownButtonFormField<String>(
                        value: itemStatus,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)
                              .translate('item_status'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
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
                onPressed: () => Navigator.of(context).pop(),
                child: Text(AppLocalizations.of(context).translate('cancel')),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    final updatedItem = item.copyWith(
                      name: controllers['name']!.text,
                      description: controllers['description']!.text,
                      sku: controllers['sku']!.text,
                      barcode: controllers['barcode']!.text,
                      purchasePrice:
                          double.tryParse(controllers['purchasePrice']!.text),
                      salePrice:
                          double.tryParse(controllers['salePrice']!.text),
                      wholesalePrice:
                          double.tryParse(controllers['wholesalePrice']!.text),
                      taxRate: double.tryParse(controllers['taxRate']!.text),
                      quantity: int.tryParse(controllers['quantity']!.text),
                      alertQuantity:
                          int.tryParse(controllers['alertQuantity']!.text),
                      image: path,
                      brand: controllers['brand']!.text,
                      size: controllers['size']!.text,
                      weight: double.tryParse(controllers['weight']!.text),
                      color: controllers['color']!.text,
                      material: controllers['material']!.text,
                      warranty: controllers['warranty']!.text,
                      supplierId: int.tryParse(controllers['supplierId']!.text),
                      itemStatus: itemStatus!,
                      dateModified: DateTime.now(),
                    );
                    await ItemDatabaseHelper.instance.updateItem(updatedItem);
                    loadItems();
                    Navigator.of(context).pop();
                  }
                },
                child: Text(AppLocalizations.of(context).translate('update')),
              ),
            ],
          );
        },
      );
    },
  );
}

Future<void> _selectDate(
    BuildContext context, TextEditingController controller) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  if (picked != null) {
    controller.text = picked.toIso8601String().split('T')[0];
  }
}
