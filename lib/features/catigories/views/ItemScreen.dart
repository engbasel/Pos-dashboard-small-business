import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/catigories/database/Categorydatabase_helper.dart';
import 'package:pos_dashboard_v1/features/catigories/models/CategoryModel.dart';

class ItemScreen extends StatefulWidget {
  final int categoryId;

  const ItemScreen({super.key, required this.categoryId});

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final data =
        await CategoryDatabaseHelper.instance.getItems(widget.categoryId);
    setState(() {
      items = data;
    });
  }

  Future<void> _showAddItemDialog() async {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty) {
                  await CategoryDatabaseHelper.instance.insertItem(
                    Item(
                      categoryId: widget.categoryId,
                      name: nameController.text,
                      description: descriptionController.text,
                    ),
                  );
                  _loadItems();
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text(item.description),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await CategoryDatabaseHelper.instance.deleteItem(item.id!);
                _loadItems();
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
