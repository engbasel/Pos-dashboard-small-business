import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/func/check_lang.dart';
import 'package:pos_dashboard_v1/features/categories/database/item_database_helper.dart';
import 'package:pos_dashboard_v1/features/categories/models/item_model.dart';

class NotificationPopup extends StatefulWidget {
  const NotificationPopup({super.key});

  @override
  State<NotificationPopup> createState() => _NotificationPopupState();
}

class _NotificationPopupState extends State<NotificationPopup> {
  late Future<List<ItemModel>> _itemsBelowAlertQuantity;

  @override
  void initState() {
    super.initState();
    _itemsBelowAlertQuantity = _fetchItemsBelowAlertQuantity();
  }

  Future<List<ItemModel>> _fetchItemsBelowAlertQuantity() async {
    final dbHelper = ItemDatabaseHelper.instance;
    return await dbHelper.getItemsBelowAlertQuantity();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 36,
          left: isArabic(context) ? 120 : null,
          right: isArabic(context) ? null : 120,
          child: AlertDialog(
            title: const Text('Notification'),
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.all(16),
            elevation: 3,
            shadowColor: Colors.grey,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * .4,
              height: MediaQuery.of(context).size.height * .5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FutureBuilder<List<ItemModel>>(
                      future: _itemsBelowAlertQuantity,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.green,
                            ),
                            child: const Text(
                              'All products have sufficient quantity.',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else {
                          final items = snapshot.data!;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final item = items[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.red[100],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Item ID: ${item.id}'),
                                    Text('Name: ${item.name}'),
                                    Text('Quantity: ${item.quantity}'),
                                    Text('price: ${item.price}'),
                                    Text(
                                        'Alert Quantity: ${item.alertQuantity}')
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
        // NotificationItem(
                    //     text: "You dont have enough products in the store"),
                    // NotificationItem(text: "This item is needed"),
                    // NotificationItem(text: "This item is needed"),
                    // NotificationItem(text: "This item is needed"),
                    // NotificationItem(text: "This item is needed"),
                    // NotificationItem(text: "This item is needed"),
                    // NotificationItem(text: "This item is needed"),
                    // NotificationItem(text: "This item is needed"),
                    // NotificationItem(text: "This item is needed"),