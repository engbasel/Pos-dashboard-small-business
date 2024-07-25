// ignore: file_names
import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/catigories/models/ItemModel.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../database/item_database_helper.dart';
import '../../../../l10n/app_localizations.dart';

class EditItemScreen extends StatefulWidget {
  final ItemModel item;

  const EditItemScreen({super.key, required this.item});

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  late final Map<String, TextEditingController> controllers;
  String? itemStatus;

  @override
  void initState() {
    super.initState();
    controllers = {
      'name': TextEditingController(text: widget.item.name),
      'description': TextEditingController(text: widget.item.description),
      'sku': TextEditingController(text: widget.item.sku),
      'barcode': TextEditingController(text: widget.item.barcode),
      'purchasePrice':
          TextEditingController(text: widget.item.purchasePrice?.toString()),
      'salePrice':
          TextEditingController(text: widget.item.salePrice?.toString()),
      'wholesalePrice':
          TextEditingController(text: widget.item.wholesalePrice?.toString()),
      'taxRate': TextEditingController(text: widget.item.taxRate?.toString()),
      'quantity': TextEditingController(text: widget.item.quantity?.toString()),
      'alertQuantity':
          TextEditingController(text: widget.item.alertQuantity?.toString()),
      'image': TextEditingController(text: widget.item.image),
      'brand': TextEditingController(text: widget.item.brand),
      'size': TextEditingController(text: widget.item.size),
      'weight': TextEditingController(text: widget.item.weight?.toString()),
      'color': TextEditingController(text: widget.item.color),
      'material': TextEditingController(text: widget.item.material),
      'warranty': TextEditingController(text: widget.item.warranty),
      'supplierId':
          TextEditingController(text: widget.item.supplierId?.toString()),
    };
    itemStatus = widget.item.itemStatus;
  }

  @override
  void dispose() {
    controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  Future<void> updateItem() async {
    if (controllers['name']!.text.isNotEmpty && itemStatus != null) {
      await ItemDatabaseHelper.instance.updateItem(
        widget.item.copyWith(
          name: controllers['name']!.text,
          description: controllers['description']!.text,
          sku: controllers['sku']!.text,
          barcode: controllers['barcode']!.text,
          purchasePrice: double.tryParse(controllers['purchasePrice']!.text),
          salePrice: double.tryParse(controllers['salePrice']!.text),
          wholesalePrice: double.tryParse(controllers['wholesalePrice']!.text),
          taxRate: double.tryParse(controllers['taxRate']!.text),
          quantity: int.tryParse(controllers['quantity']!.text),
          alertQuantity: int.tryParse(controllers['alertQuantity']!.text),
          image: controllers['image']!.text,
          brand: controllers['brand']!.text,
          size: controllers['size']!.text,
          weight: double.tryParse(controllers['weight']!.text),
          color: controllers['color']!.text,
          material: controllers['material']!.text,
          warranty: controllers['warranty']!.text,
          supplierId: int.tryParse(controllers['supplierId']!.text),
          itemStatus: itemStatus!,
          dateModified: DateTime.now(),
        ),
      );
      Navigator.of(context).pop(widget.item.copyWith(
        name: controllers['name']!.text,
        description: controllers['description']!.text,
        sku: controllers['sku']!.text,
        barcode: controllers['barcode']!.text,
        purchasePrice: double.tryParse(controllers['purchasePrice']!.text),
        salePrice: double.tryParse(controllers['salePrice']!.text),
        wholesalePrice: double.tryParse(controllers['wholesalePrice']!.text),
        taxRate: double.tryParse(controllers['taxRate']!.text),
        quantity: int.tryParse(controllers['quantity']!.text),
        alertQuantity: int.tryParse(controllers['alertQuantity']!.text),
        image: controllers['image']!.text,
        brand: controllers['brand']!.text,
        size: controllers['size']!.text,
        weight: double.tryParse(controllers['weight']!.text),
        color: controllers['color']!.text,
        material: controllers['material']!.text,
        warranty: controllers['warranty']!.text,
        supplierId: int.tryParse(controllers['supplierId']!.text),
        itemStatus: itemStatus!,
        dateModified: DateTime.now(),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)
              .translate('please_fill_required_fields')),
        ),
      );
    }
  }

  Widget buildTextField(String key, String label,
      {TextInputType keyboardType = TextInputType.text, String? hintText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controllers[key],
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).translate(label),
          hintText: hintText != null
              ? AppLocalizations.of(context).translate(hintText)
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        ),
        cursorColor: Colors.blue,
        style: const TextStyle(color: Colors.black87),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context).translate('field_required');
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('edit_item')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField('name', 'item_name'),
              buildTextField('description', 'description'),
              buildTextField('sku', 'sku'),
              buildTextField('barcode', 'barcode'),
              buildTextField('purchasePrice', 'purchase_price',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true)),
              buildTextField('salePrice', 'sale_price',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true)),
              buildTextField('wholesalePrice', 'wholesale_price',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true)),
              buildTextField('taxRate', 'tax_rate',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true)),
              buildTextField('quantity', 'quantity',
                  keyboardType: TextInputType.number),
              buildTextField('alertQuantity', 'alert_quantity',
                  keyboardType: TextInputType.number),
              buildTextField('image', 'image'),
              buildTextField('brand', 'brand'),
              buildTextField('size', 'size'),
              buildTextField('weight', 'weight',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true)),
              buildTextField('color', 'color'),
              buildTextField('material', 'material'),
              buildTextField('warranty', 'warranty'),
              buildTextField('supplierId', 'supplier_id',
                  keyboardType: TextInputType.number),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DropdownButtonFormField<String>(
                  value: itemStatus,
                  decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context).translate('item_status'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                          color: Colors.blueAccent, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                  items: ['active', 'inactive', 'discontinued']
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(
                                AppLocalizations.of(context).translate(status)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      itemStatus = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                bgColor: Colors.teal,
                text: AppLocalizations.of(context).translate('update_item'),
                onTap: updateItem,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
