import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/db/Log_file_database_helper.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/features/categories/database/item_database_helper.dart';
import 'package:pos_dashboard_v1/features/categories/models/item_model.dart';
import 'package:pos_dashboard_v1/features/notifications/view/notification_view.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/profile_dialog.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/user_info_section.dart';

import '../../../l10n/app_localizations.dart';

class OverviewView extends StatefulWidget {
  const OverviewView({super.key});

  @override
  State<OverviewView> createState() => _OverviewViewState();
}

class _OverviewViewState extends State<OverviewView> {
  late Future<List<ItemModel>> _itemsBelowAlertQuantity;
  int? itemsNum;
  final Sqldb sqldb = Sqldb();
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    loadUserData();
    _itemsBelowAlertQuantity = _fetchItemsBelowAlertQuantity();

    _fetchItemsBelowAlertQuantity().then((items) {
      setState(() {
        _itemsBelowAlertQuantity = Future.value(items);
        itemsNum = items.length;
      });
    });
  }

  void loadUserData() async {
    users = await sqldb.getUserData();
    setState(() {});
  }

  Future<List<ItemModel>> _fetchItemsBelowAlertQuantity() async {
    final dbHelper = ItemDatabaseHelper.instance;
    return await dbHelper.getItemsBelowAlertQuantity();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            title: AppLocalizations.of(context).translate('dashboard'),
            actions: [
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return const NotificationPopup();
                    },
                  );
                },
                child: Badge(
                  isLabelVisible: itemsNum == 0 ? false : true,
                  backgroundColor: ColorsManager.kPrimaryColor,
                  label: Text(
                    itemsNum.toString(),
                  ),
                  child: const Icon(
                    Icons.notifications_none_outlined,
                    color: Color(0xff505251),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return ProfileDialog(users: users);
                    },
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      users.isEmpty
                          ? ''
                          : '${users[users.length - 1]['username']}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.keyboard_arrow_down_outlined),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UserInfoSection(),
                const SizedBox(height: 16),
                FutureBuilder<List<ItemModel>>(
                  future: _itemsBelowAlertQuantity,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text(
                          '${AppLocalizations.of(context).translate('error')}: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.green,
                        ),
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('Allproductshavesufficientquantity'),
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      final items = snapshot.data!;
                      // Create a list with the static text and fetched items
                      final displayedItems = [
                        (AppLocalizations.of(context)
                            .translate('Deficiencies')),
                        ...items,
                      ];

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: displayedItems.length,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            // Return the static text as the first item
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color:
                                    Colors.blue[100], // Adjust color if needed
                              ),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('Deficiencies'),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            );
                          } else {
                            // Return the actual item from the fetched list
                            final item = displayedItems[index] as ItemModel;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.red[100],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${AppLocalizations.of(context).translate('ItemID')}: ${item.id}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                        '${AppLocalizations.of(context).translate('nameLabel')}: ${item.name}'),
                                    Text(
                                        '${AppLocalizations.of(context).translate('quantity')}: ${item.quantity}'),
                                    Text(
                                        '${AppLocalizations.of(context).translate('alert_quantity')}: ${item.alertQuantity}'),
                                    // Add more fields if needed
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
