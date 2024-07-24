import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/catigories/models/ItemModel.dart';

import '../../../l10n/app_localizations.dart';

class ItemDetailsScreen extends StatelessWidget {
  final ItemModel item;

  const ItemDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('item_details')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ListTile(
              title: Text(AppLocalizations.of(context).translate('item_name')),
              subtitle: Text(item.name),
            ),
            ListTile(
              title:
                  Text(AppLocalizations.of(context).translate('description')),
              subtitle: Text(item.description),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).translate('sku')),
              subtitle: Text(item.sku ?? '-'),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).translate('barcode')),
              subtitle: Text(item.barcode ?? '-'),
            ),
            ListTile(
              title: Text(
                  AppLocalizations.of(context).translate('purchase_price')),
              subtitle: Text(item.purchasePrice?.toString() ?? '-'),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).translate('sale_price')),
              subtitle: Text(item.salePrice?.toString() ?? '-'),
            ),
            ListTile(
              title: Text(
                  AppLocalizations.of(context).translate('wholesale_price')),
              subtitle: Text(item.wholesalePrice?.toString() ?? '-'),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).translate('tax_rate')),
              subtitle: Text(item.taxRate?.toString() ?? '-'),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).translate('quantity')),
              subtitle: Text(item.quantity?.toString() ?? '-'),
            ),
            ListTile(
              title: Text(
                  AppLocalizations.of(context).translate('alert_quantity')),
              subtitle: Text(item.alertQuantity?.toString() ?? '-'),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).translate('image')),
              subtitle: Text(item.image ?? '-'),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).translate('brand')),
              subtitle: Text(item.brand ?? '-'),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).translate('size')),
              subtitle: Text(item.size ?? '-'),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).translate('weight')),
              subtitle: Text(item.weight?.toString() ?? '-'),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).translate('color')),
              subtitle: Text(item.color ?? '-'),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).translate('material')),
              subtitle: Text(item.material ?? '-'),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).translate('warranty')),
              subtitle: Text(item.warranty ?? '-'),
            ),
            ListTile(
              title:
                  Text(AppLocalizations.of(context).translate('supplier_id')),
              subtitle: Text(item.supplierId?.toString() ?? '-'),
            ),
            ListTile(
              title:
                  Text(AppLocalizations.of(context).translate('item_status')),
              subtitle: Text(item.itemStatus ?? '-'),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).translate('date_added')),
              subtitle: Text(item.dateAdded.toString()),
            ),
            ListTile(
              title:
                  Text(AppLocalizations.of(context).translate('date_modified')),
              subtitle: Text(item.dateModified.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
