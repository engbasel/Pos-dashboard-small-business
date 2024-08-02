import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/categories/models/item_model.dart';
import 'item_details_screen.dart';

Widget buildGridView(
    BuildContext context, List<ItemModel> filteredItems, Function updateItem) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3, // 3 cards per row
      childAspectRatio: 3 / 2, // Adjust aspect ratio as needed
    ),
    itemCount: filteredItems.length,
    itemBuilder: (context, index) {
      final item = filteredItems[index];
      return Card(
        margin: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () async {
            // Navigate to ItemDetailsScreen with the selected item
            showDialog(
              context: context,
              builder: (context) => ItemDetailsDialog(item: item),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: item.image != null && item.image!.isNotEmpty
                    ? Image.file(
                        File(item.image!),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : const Icon(Icons.image, size: 100),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  item.name,
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '\$${item.unitPrice?.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
