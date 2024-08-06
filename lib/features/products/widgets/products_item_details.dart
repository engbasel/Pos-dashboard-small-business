import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/categories/models/item_model.dart';
import 'package:pos_dashboard_v1/features/products/widgets/products_item_details_row.dart';

class ProductItemDetails extends StatelessWidget {
  final ItemModel item;

  const ProductItemDetails({super.key, required this.item});

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
              ProductsItemDetailsRow(
                labelKey: 'item_name',
                value: item.name,
              ),
              const Divider(),
              ProductsItemDetailsRow(
                labelKey: 'description',
                value: item.description,
              ),
              const Divider(),
              ProductsItemDetailsRow(
                labelKey: 'sku',
                value: item.sku,
              ),
              const Divider(),
              ProductsItemDetailsRow(
                labelKey: 'barcode',
                value: item.barcode,
              ),
              const Divider(),
              ProductsItemDetailsRow(
                labelKey: 'purchase_price',
                value: item.price?.toString(),
              ),
              const Divider(),
              ProductsItemDetailsRow(
                labelKey: 'sale_price',
                value: item.unitPrice?.toString(),
              ),
              const Divider(),
              ProductsItemDetailsRow(
                labelKey: 'wholesale_price',
                value: item.wholesalePrice?.toString(),
              ),
              const Divider(),
              ProductsItemDetailsRow(
                labelKey: 'tax_rate',
                value: item.taxRate?.toString(),
              ),
              const Divider(),
              ProductsItemDetailsRow(
                labelKey: 'quantity',
                value: item.quantity?.toString(),
              ),
              const Divider(),
              ProductsItemDetailsRow(
                labelKey: 'alert_quantity',
                value: item.alertQuantity?.toString(),
              ),
              const Divider(),
              ProductsItemDetailsRow(
                labelKey: 'image_url',
                value: item.image,
              ),
              const Divider(),
              ProductsItemDetailsRow(
                labelKey: 'brand',
                value: item.brand,
              ),
              const Divider(),
              ProductsItemDetailsRow(
                labelKey: 'size',
                value: item.size,
              ),
              const Divider(),
              ProductsItemDetailsRow(
                labelKey: 'weight',
                value: item.weight?.toString(),
              ),
              const Divider(),
              ProductsItemDetailsRow(
                labelKey: 'color',
                value: item.color,
              ),
              const Divider(),
              ProductsItemDetailsRow(
                labelKey: 'material',
                value: item.material,
              ),
              const Divider(),
              ProductsItemDetailsRow(
                labelKey: 'warranty',
                value: item.warranty,
              ),
              const Divider(),
              ProductsItemDetailsRow(
                labelKey: 'supplier_id',
                value: item.supplierId?.toString(),
              ),
              const Divider(),
              ProductsItemDetailsRow(
                labelKey: 'item_status',
                value: item.itemStatus,
              ),
              const Divider(),
              ProductsItemDetailsRow(
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
