import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/categories/database/category_database_helper.dart';
import 'package:pos_dashboard_v1/features/categories/database/item_database_helper.dart';
import 'package:pos_dashboard_v1/features/categories/models/item_model.dart';
import 'package:pos_dashboard_v1/features/overview/widgets/custom_label.dart';
import 'package:pos_dashboard_v1/l10n/app_localizations.dart';
import '../../../core/utils/manager/manager.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class UserInfoSection extends StatefulWidget {
  const UserInfoSection({super.key});

  @override
  State<UserInfoSection> createState() => _UserInfoSectionState();
}

class _UserInfoSectionState extends State<UserInfoSection> {
  late Timer _timer;
  late String _currentDateTime;
  final ValueNotifier<int> _categoryCountNotifier = ValueNotifier<int>(0);
  late Future<List<ItemModel>> itemsBelowAlertQuantity;
  int? itemsNum;

  @override
  void initState() {
    super.initState();
    updateDateTime();
    _timer =
        Timer.periodic(const Duration(seconds: 1), (timer) => updateDateTime());
    loadCategoryCount();
    itemsBelowAlertQuantity = _fetchItemsBelowAlertQuantity();

    _fetchItemsBelowAlertQuantity().then((items) {
      setState(() {
        itemsBelowAlertQuantity = Future.value(items);
        itemsNum = items.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _categoryCountNotifier.dispose();
    super.dispose();
  }

  Future<List<ItemModel>> _fetchItemsBelowAlertQuantity() async {
    final dbHelper = ItemDatabaseHelper.instance;
    return await dbHelper.getItemsBelowAlertQuantity();
  }

  void updateDateTime() {
    setState(() {
      _currentDateTime = getCurrentDateTime();
    });
  }

  String getCurrentDateTime() {
    final now = DateTime.now();
    final dayFormatter = DateFormat('EEEE');
    final dateTimeFormatter = DateFormat('MMM dd, yyyy hh:mm:ss a');
    return '${dayFormatter.format(now)} ${dateTimeFormatter.format(now)}';
  }

  Future<void> loadCategoryCount() async {
    int count = await CategoryDatabaseHelper.instance.getCategoryCount();
    _categoryCountNotifier.value = count;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomLabel(
                color: const Color(0xfff3e5f5),
                labelValue: appLocalizations.translate('dateTodayAndTimeNow'),
                content: _currentDateTime,
                imagename: ImagesManger.edit,
              ),
              ValueListenableBuilder<int>(
                valueListenable: _categoryCountNotifier,
                builder: (context, categoryCount, child) {
                  return CustomLabel(
                    color: const Color(0xfffff2cc),
                    labelValue:
                        appLocalizations.translate('numberOfCategories'),
                    content: '$categoryCount Categories',
                    imagename: ImagesManger.mail,
                  );
                },
              ),
              CustomLabel(
                color: const Color(0xffe0f7fa),
                labelValue: appLocalizations.translate('totalPaymentsToday'),
                content: '\$1,234.56',
                imagename: ImagesManger.shoppingbag,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomLabel(
                color: const Color(0xffffebee),
                labelValue:
                    appLocalizations.translate('totalBillExportedToday'),
                content: '42',
                imagename: ImagesManger.sex,
              ),
              CustomLabel(
                color: const Color(0xffe8f5e9),
                labelValue:
                    appLocalizations.translate('totalReturnProductsToday'),
                content: 'John Doe - Cashier',
                imagename: ImagesManger.sex,
              ),
              CustomLabel(
                color: const Color(0xfffff3e0),
                labelValue: appLocalizations.translate('notifications'),
                content:
                    ' ${appLocalizations.translate('newalerts')} ${itemsNum.toString()}',
                imagename: ImagesManger.sex,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// new alerts