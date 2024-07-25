import 'package:flutter/material.dart';
import 'package:pos_dashboard_v1/features/catigories/models/ItemModel.dart';
import 'package:pos_dashboard_v1/features/catigories/views/EditItemScreen.dart';

import '../../../l10n/app_localizations.dart';

class DetailListTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const DetailListTile({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}

class ItemDetailsScreen extends StatefulWidget {
  final ItemModel item;

  const ItemDetailsScreen({super.key, required this.item});

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  late ItemModel _item;

  @override
  void initState() {
    super.initState();
    _item = widget.item;
  }

  void _navigateToEditScreen() async {
    final updatedItem = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditItemScreen(item: _item)),
    );

    if (updatedItem != null) {
      setState(() {
        _item = updatedItem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('item_details')),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _navigateToEditScreen,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            DetailListTile(
              title: AppLocalizations.of(context).translate('item_name'),
              subtitle: _item.name,
            ),
            DetailListTile(
              title: AppLocalizations.of(context).translate('description'),
              subtitle: _item.description,
            ),
            DetailListTile(
              title: AppLocalizations.of(context).translate('sku'),
              subtitle: _item.sku ?? '-',
            ),
            DetailListTile(
              title: AppLocalizations.of(context).translate('barcode'),
              subtitle: _item.barcode ?? '-',
            ),
            DetailListTile(
              title: AppLocalizations.of(context).translate('purchase_price'),
              subtitle: _item.purchasePrice?.toString() ?? '-',
            ),
            DetailListTile(
              title: AppLocalizations.of(context).translate('sale_price'),
              subtitle: _item.salePrice?.toString() ?? '-',
            ),
            DetailListTile(
              title: AppLocalizations.of(context).translate('wholesale_price'),
              subtitle: _item.wholesalePrice?.toString() ?? '-',
            ),
            DetailListTile(
              title: AppLocalizations.of(context).translate('tax_rate'),
              subtitle: _item.taxRate?.toString() ?? '-',
            ),
            DetailListTile(
              title: AppLocalizations.of(context).translate('quantity'),
              subtitle: _item.quantity?.toString() ?? '-',
            ),
            DetailListTile(
              title: AppLocalizations.of(context).translate('alert_quantity'),
              subtitle: _item.alertQuantity?.toString() ?? '-',
            ),
            DetailListTile(
              title: AppLocalizations.of(context).translate('image'),
              subtitle: _item.image ?? '-',
            ),
            DetailListTile(
              title: AppLocalizations.of(context).translate('brand'),
              subtitle: _item.brand ?? '-',
            ),
            DetailListTile(
              title: AppLocalizations.of(context).translate('size'),
              subtitle: _item.size ?? '-',
            ),
            DetailListTile(
              title: AppLocalizations.of(context).translate('weight'),
              subtitle: _item.weight?.toString() ?? '-',
            ),
            DetailListTile(
              title: AppLocalizations.of(context).translate('color'),
              subtitle: _item.color ?? '-',
            ),
            DetailListTile(
              title: AppLocalizations.of(context).translate('material'),
              subtitle: _item.material ?? '-',
            ),
            DetailListTile(
              title: AppLocalizations.of(context).translate('warranty'),
              subtitle: _item.warranty ?? '-',
            ),
            DetailListTile(
              title: AppLocalizations.of(context).translate('supplier_id'),
              subtitle: _item.supplierId?.toString() ?? '-',
            ),
            DetailListTile(
              title: AppLocalizations.of(context).translate('item_status'),
              subtitle: _item.itemStatus ?? '-',
            ),
            // DetailListTile(
            //   title: AppLocalizations.of(context).translate('date_added'),
            //   subtitle: _item.dateAdded.toString(),
            // ),
            // DetailListTile(
            //   title: AppLocalizations.of(context).translate('date_modified'),
            //   subtitle: _item.da.toString(),
            // ),
          ],
        ),
      ),
    );
  }
}
