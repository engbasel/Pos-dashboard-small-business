import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/categories/models/item_model.dart';
import 'package:pos_dashboard_v1/features/categories/views/Items/widgets/edit_item_view.dart';
import '../../../database/item_database_helper.dart';
import '../widgets/item_details_screen.dart';

Widget buildListView(
  BuildContext context,
  List<ItemModel> filteredItems,
  Function updateItem,
  Future<void> Function() loadItems,
) {
  return ListView.builder(
    itemCount: filteredItems.length,
    itemBuilder: (context, index) {
      final item = filteredItems[index];
      return ListTile(
        leading: item.image != null && item.image!.isNotEmpty
            ? Image.file(
                File(item.image!),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : const Icon(Icons.image, size: 50),
        title: Text(item.name),
        subtitle: Text(item.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                showEditItemDialog(context, item, loadItems);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await ItemDatabaseHelper.instance.deleteItem(item.id!);
                await loadItems(); // Reload items after deletion
              },
            ),
          ],
        ),
        onTap: () async {
          // Navigate to ItemDetailsScreen with the selected item
          final result = showDialog(
            context: context,
            builder: (context) => ItemDetailsDialog(item: item),
          );

          if (result is ItemModel) {
            updateItem(result);
          }
        },
      );
    },
  );
}
