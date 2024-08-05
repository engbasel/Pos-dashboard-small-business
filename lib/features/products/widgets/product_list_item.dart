import 'package:flutter/material.dart';
import 'dart:io';
import 'package:pos_dashboard_v1/features/categories/models/item_model.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';
import 'package:pos_dashboard_v1/features/products/widgets/products_item_details.dart';
import 'package:pos_dashboard_v1/features/products/widgets/products_item_edit.dart';

class ProductListItem extends StatelessWidget {
  final ItemModel item;
  final VoidCallback onRemove;
  final Future<void> Function() loadItems;

  const ProductListItem({
    super.key,
    required this.item,
    required this.onRemove,
    required this.loadItems,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: ColorsManager.backgroundColor,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        leading: item.image != null
            ? Image.file(
                File(item.image!),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : const Icon(Icons.image, size: 50),
        title: Text(
          item.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(item.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: ColorsManager.kPrimaryColor,
              ),
              onPressed: () async {
                showEditProductsItemDialog(context, item, loadItems);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onRemove,
            ),
          ],
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ProductItemDetails(item: item);
            },
          );
        },
      ),
    );
  }
}
