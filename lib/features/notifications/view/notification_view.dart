import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/func/check_lang.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';
import 'package:pos_dashboard_v1/features/categories/database/item_database_helper.dart';
import 'package:pos_dashboard_v1/features/categories/models/item_model.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';

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
          left: isArabic(context) ? 80 : null,
          right: isArabic(context) ? null : 80,
          child: AlertDialog(
            title:
                Text(AppLocalizations.of(context).translate('notifications')),
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.all(16),
            elevation: 3,
            shadowColor: Colors.grey,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * .35,
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
                          return Text(
                              '${AppLocalizations.of(context).translate('error')}: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 6),
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  (AppLocalizations.of(context).translate(
                                      'Allproductshavesufficientquantity')),
                                  style: const TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ],
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
                                margin: const EdgeInsets.only(bottom: 6),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: ColorsManager.kPrimaryColor
                                      .withOpacity(.8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${AppLocalizations.of(context).translate('nameLabel')}: ${item.name}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '${AppLocalizations.of(context).translate('quantity')}: ${item.quantity}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '${AppLocalizations.of(context).translate('alert_quantity')}: ${item.alertQuantity}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
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
