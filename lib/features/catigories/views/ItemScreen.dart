import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/catigories/database/item_database_helper.dart';
import 'package:pos_dashboard_v1/features/catigories/models/ItemModel.dart';
import 'item_details_screen.dart'; // Import the updated ItemDetailsScreen

import '../../../l10n/app_localizations.dart';

class ItemScreen extends StatefulWidget {
  final int categoryId;

  const ItemScreen({super.key, required this.categoryId});

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  List<ItemModel> items = [];
  List<ItemModel> filteredItems = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadItems();
    searchController.addListener(filterItems);
  }

  Future<void> loadItems() async {
    final data = await ItemDatabaseHelper.instance.getItems(widget.categoryId);
    setState(() {
      items = data;
      filteredItems = data;
    });
  }

  void filterItems() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = items.where((item) {
        return item.name.toLowerCase().contains(query) ||
            item.description.toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> showAddItemDialog(BuildContext context, int categoryId) async {
    // Existing code for showing add item dialog
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _updateItem(ItemModel updatedItem) async {
    final index = items.indexWhere((item) => item.id == updatedItem.id);
    if (index != -1) {
      setState(() {
        items[index] = updatedItem;
        filteredItems[index] = updatedItem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('items')),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context).translate('search_items'),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: filteredItems.isEmpty
                ? Center(
                    child: Text(AppLocalizations.of(context)
                        .translate('item_not_available')),
                  )
                : ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text(item.description),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await ItemDatabaseHelper.instance
                                .deleteItem(item.id!);
                            loadItems();
                          },
                        ),
                        onTap: () async {
                          final result = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ItemDetailsScreen(item: item),
                            ),
                          );
                          if (result != null && result is ItemModel) {
                            _updateItem(result);
                          }
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddItemDialog(context, widget.categoryId);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
