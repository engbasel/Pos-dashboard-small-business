import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/categories/database/item_database_helper.dart';
import 'package:pos_dashboard_v1/features/categories/models/item_model.dart';
import 'package:pos_dashboard_v1/features/categories/views/Items/item_dialog.dart';
import 'package:pos_dashboard_v1/features/categories/views/Items/item_grid_view.dart';
import 'package:pos_dashboard_v1/features/categories/views/Items/item_list_view.dart';
import '../../../../l10n/app_localizations.dart';

class ItemScreen extends StatefulWidget {
  final int categoryId;

  const ItemScreen({super.key, required this.categoryId});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  List<ItemModel> items = [];
  List<ItemModel> filteredItems = [];
  TextEditingController searchController = TextEditingController();
  bool isGridView = false;

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

  Future<void> updateItem(ItemModel updatedItem) async {
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
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(AppLocalizations.of(context).translate('items')),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.view_list : Icons.view_module),
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context).translate('search_items'),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filteredItems.isEmpty
                  ? Center(
                      child: Text(AppLocalizations.of(context)
                          .translate('item_not_available')),
                    )
                  : isGridView
                      ? buildGridView(context, filteredItems, updateItem)
                      : buildListView(
                          context, filteredItems, updateItem, loadItems),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddItemDialog(context, widget.categoryId, loadItems);
        },
        backgroundColor: const Color(0xff4985FF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
