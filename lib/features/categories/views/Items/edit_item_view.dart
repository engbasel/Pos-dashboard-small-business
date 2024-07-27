import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_button.dart';
import 'package:pos_dashboard_v1/features/categories/models/item_model.dart';
import '../../database/item_database_helper.dart';
import '../../../../l10n/app_localizations.dart';

class EditItemScreen extends StatefulWidget {
  final ItemModel item;

  const EditItemScreen({super.key, required this.item});

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController skuController;
  late TextEditingController barcodeController;
  late TextEditingController purchasePriceController;
  late TextEditingController salePriceController;
  late TextEditingController wholesalePriceController;
  late TextEditingController taxRateController;
  late TextEditingController quantityController;
  late TextEditingController alertQuantityController;
  late TextEditingController imageController;
  late TextEditingController brandController;
  late TextEditingController sizeController;
  late TextEditingController weightController;
  late TextEditingController colorController;
  late TextEditingController materialController;
  late TextEditingController warrantyController;
  late TextEditingController supplierIdController;
  String? itemStatus;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.item.name);
    descriptionController =
        TextEditingController(text: widget.item.description);
    skuController = TextEditingController(text: widget.item.sku);
    barcodeController = TextEditingController(text: widget.item.barcode);
    purchasePriceController =
        TextEditingController(text: widget.item.price?.toString());
    salePriceController =
        TextEditingController(text: widget.item.unitPrice?.toString());
    wholesalePriceController =
        TextEditingController(text: widget.item.wholesalePrice?.toString());
    taxRateController =
        TextEditingController(text: widget.item.taxRate?.toString());
    quantityController =
        TextEditingController(text: widget.item.quantity?.toString());
    alertQuantityController =
        TextEditingController(text: widget.item.alertQuantity?.toString());
    imageController = TextEditingController(text: widget.item.image);
    brandController = TextEditingController(text: widget.item.brand);
    sizeController = TextEditingController(text: widget.item.size);
    weightController =
        TextEditingController(text: widget.item.weight?.toString());
    colorController = TextEditingController(text: widget.item.color);
    materialController = TextEditingController(text: widget.item.material);
    warrantyController = TextEditingController(text: widget.item.warranty);
    supplierIdController =
        TextEditingController(text: widget.item.supplierId?.toString());
    itemStatus = widget.item.itemStatus;
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    skuController.dispose();
    barcodeController.dispose();
    purchasePriceController.dispose();
    salePriceController.dispose();
    wholesalePriceController.dispose();
    taxRateController.dispose();
    quantityController.dispose();
    alertQuantityController.dispose();
    imageController.dispose();
    brandController.dispose();
    sizeController.dispose();
    weightController.dispose();
    colorController.dispose();
    materialController.dispose();
    warrantyController.dispose();
    supplierIdController.dispose();
    super.dispose();
  }

  Future<void> _updateItem() async {
    if (nameController.text.isNotEmpty && itemStatus != null) {
      await ItemDatabaseHelper.instance.updateItem(
        widget.item.copyWith(
          name: nameController.text,
          description: descriptionController.text,
          sku: skuController.text,
          barcode: barcodeController.text,
          purchasePrice: double.tryParse(purchasePriceController.text),
          salePrice: double.tryParse(salePriceController.text),
          wholesalePrice: double.tryParse(wholesalePriceController.text),
          taxRate: double.tryParse(taxRateController.text),
          quantity: int.tryParse(quantityController.text),
          alertQuantity: int.tryParse(alertQuantityController.text),
          image: imageController.text,
          brand: brandController.text,
          size: sizeController.text,
          weight: double.tryParse(weightController.text),
          color: colorController.text,
          material: materialController.text,
          warranty: warrantyController.text,
          supplierId: int.tryParse(supplierIdController.text),
          itemStatus: itemStatus!,
          dateModified: DateTime.now(),
        ),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)
              .translate('please_fill_required_fields')),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(AppLocalizations.of(context).translate('Edit Item')),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context).translate('item_name'),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context).translate('description'),
                ),
              ),
              const SizedBox(height: 20),
              // Other fields follow the same pattern...
              DropdownButtonFormField<String>(
                value: itemStatus,
                decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context).translate('item_status'),
                ),
                items: ['active', 'inactive', 'discontinued']
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(
                            AppLocalizations.of(context).translate(status),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    itemStatus = value;
                  });
                },
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: CustomButton(
                  text: AppLocalizations.of(context).translate('save'),
                  onTap: _updateItem,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
