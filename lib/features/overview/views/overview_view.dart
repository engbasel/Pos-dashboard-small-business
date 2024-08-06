import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';
import 'package:pos_dashboard_v1/core/widgets/custom_app_bar.dart';
import 'package:pos_dashboard_v1/features/authentication/create_account/database/accounts_db_helper.dart';
import 'package:pos_dashboard_v1/features/authentication/create_account/models/createAccounts.dart';
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
  late Future<List<ItemModel>> itemsBelowAlertQuantity;
  int? itemsNum;
  AuthService authService = AuthService();
  List<Account> users = [];

  @override
  void initState() {
    super.initState();
    loadUserData();
    itemsBelowAlertQuantity = _fetchItemsBelowAlertQuantity();

    _fetchItemsBelowAlertQuantity().then((items) {
      setState(() {
        itemsBelowAlertQuantity = Future.value(items);
        itemsNum = items.length;
      });
    });
  }

  void loadUserData() async {
    users = await authService.getAllAccounts();
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
                      users.isEmpty ? '' : '${users[users.length - 1].name}',
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
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserInfoSection(),
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
