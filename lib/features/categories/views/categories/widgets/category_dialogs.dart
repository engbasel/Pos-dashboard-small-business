import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pos_dashboard_v1/core/utils/manager/manager.dart';
import 'package:pos_dashboard_v1/features/categories/database/category_database_helper.dart';
import '../../../models/category_model.dart';
import '../../../../../l10n/app_localizations.dart';

Future<void> showAddCategoryDialog(
    BuildContext context, Future<void> Function() loadCategories) async {
  TextEditingController titleController = TextEditingController();
  Color pickerColor = Colors.blue;

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(AppLocalizations.of(context).translate('add_category')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context).translate('category_title'),
              ),
            ),
            const SizedBox(height: 20),
            Text(AppLocalizations.of(context).translate('pick_color')),
            const SizedBox(height: 10),
            BlockPicker(
              pickerColor: pickerColor,
              onColorChanged: (color) {
                pickerColor = color;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              AppLocalizations.of(context).translate('cancel'),
              style: const TextStyle(
                color: ColorsManager.kPrimaryColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              if (titleController.text.isNotEmpty) {
                await CategoryDatabaseHelper.instance.insertCategory(
                  CategoryModel(
                    title: titleController.text,
                    color: pickerColor.value,
                  ),
                );
                loadCategories();
              }
              Navigator.of(context).pop();
            },
            child: Text(
              AppLocalizations.of(context).translate('add'),
              style: const TextStyle(
                color: ColorsManager.kPrimaryColor,
              ),
            ),
          ),
        ],
      );
    },
  );
}

Future<void> showEditCategoryDialog(BuildContext context,
    CategoryModel category, Future<void> Function() loadCategories) async {
  TextEditingController titleController =
      TextEditingController(text: category.title);
  Color pickerColor = Color(category.color);

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(AppLocalizations.of(context).translate('edit_category')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context).translate('category_title'),
              ),
            ),
            const SizedBox(height: 20),
            Text(AppLocalizations.of(context).translate('pick_color')),
            const SizedBox(height: 10),
            BlockPicker(
              pickerColor: pickerColor,
              onColorChanged: (color) {
                pickerColor = color;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              AppLocalizations.of(context).translate('cancel'),
              style: const TextStyle(
                color: ColorsManager.kPrimaryColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              if (titleController.text.isNotEmpty) {
                await CategoryDatabaseHelper.instance.updateCategory(
                  CategoryModel(
                    id: category.id,
                    title: titleController.text,
                    color: pickerColor.value,
                  ),
                );
                loadCategories();
              }
              Navigator.of(context).pop();
            },
            child: Text(
              AppLocalizations.of(context).translate('save'),
              style: const TextStyle(
                color: ColorsManager.kPrimaryColor,
              ),
            ),
          ),
        ],
      );
    },
  );
}
