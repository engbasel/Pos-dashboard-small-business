import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/categories/models/item_model.dart';
import 'package:pos_dashboard_v1/features/categories/views/Items/widgets/item_details_row.dart';

class ItemDetailsDialog extends StatelessWidget {
  final ItemModel item;

  const ItemDetailsDialog({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * .5,
        height: MediaQuery.of(context).size.height * .8,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.image != null)
                Image.file(
                  File(item.image!),
                  width: MediaQuery.of(context).size.width * .8,
                  height: 300,
                ),
              const SizedBox(height: 16),
              ItemDetailsRow(
                labelKey: 'item_name',
                value: item.name,
              ),
              const Divider(),
              ItemDetailsRow(
                labelKey: 'description',
                value: item.description,
              ),
              const Divider(),
              ItemDetailsRow(
                labelKey: 'sku',
                value: item.sku,
              ),
              const Divider(),
              ItemDetailsRow(
                labelKey: 'barcode',
                value: item.barcode,
              ),
              const Divider(),
              ItemDetailsRow(
                labelKey: 'purchase_price',
                value: item.price?.toString(),
              ),
              const Divider(),
              ItemDetailsRow(
                labelKey: 'sale_price',
                value: item.unitPrice?.toString(),
              ),
              const Divider(),
              ItemDetailsRow(
                labelKey: 'wholesale_price',
                value: item.wholesalePrice?.toString(),
              ),
              const Divider(),
              ItemDetailsRow(
                labelKey: 'tax_rate',
                value: item.taxRate?.toString(),
              ),
              const Divider(),
              ItemDetailsRow(
                labelKey: 'quantity',
                value: item.quantity?.toString(),
              ),
              const Divider(),
              ItemDetailsRow(
                labelKey: 'alert_quantity',
                value: item.alertQuantity?.toString(),
              ),
              const Divider(),
              ItemDetailsRow(
                labelKey: 'image_url',
                value: item.image,
              ),
              const Divider(),
              ItemDetailsRow(
                labelKey: 'brand',
                value: item.brand,
              ),
              const Divider(),
              ItemDetailsRow(
                labelKey: 'size',
                value: item.size,
              ),
              const Divider(),
              ItemDetailsRow(
                labelKey: 'weight',
                value: item.weight?.toString(),
              ),
              const Divider(),
              ItemDetailsRow(
                labelKey: 'color',
                value: item.color,
              ),
              const Divider(),
              ItemDetailsRow(
                labelKey: 'material',
                value: item.material,
              ),
              const Divider(),
              ItemDetailsRow(
                labelKey: 'warranty',
                value: item.warranty,
              ),
              const Divider(),
              ItemDetailsRow(
                labelKey: 'supplier_id',
                value: item.supplierId?.toString(),
              ),
              const Divider(),
              ItemDetailsRow(
                labelKey: 'item_status',
                value: item.itemStatus,
              ),
              const Divider(),
              ItemDetailsRow(
                labelKey: 'date_modified',
                value: item.dateModified?.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
